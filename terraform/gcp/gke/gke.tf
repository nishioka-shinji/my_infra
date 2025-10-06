locals {
  secondary_ranges_map = {
    for range in data.terraform_remote_state.network.outputs.subnet.secondary_ip_range : range.range_name => range
  }
}

resource "google_container_cluster" "primary" {
  name     = "my-standard-cluster"
  location = "asia-northeast2-a"

  # デフォルトノードプールを無効にし、後ほど定義するカスタムノードプールのみを使用
  remove_default_node_pool = true
  initial_node_count       = 1

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }

  network    = data.terraform_remote_state.network.outputs.network.name
  subnetwork = data.terraform_remote_state.network.outputs.subnet.name
  ip_allocation_policy {
    cluster_secondary_range_name  = local.secondary_ranges_map["pods-range"].range_name
    services_secondary_range_name = local.secondary_ranges_map["services-range"].range_name
  }

  # Goldilocksの利用に必要
  vertical_pod_autoscaling {
    enabled = true
  }

  # k8sのサービスアカウントとGCPのサービスアカウントの紐付けするために必要
  workload_identity_config {
    workload_pool = "${data.google_project.project.name}.svc.id.goog"
  }

  # k8sのGatewayリソースからCLBを作成するために必要
  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }

  # Cloud DNS for GKEの利用
  dns_config {
    cluster_dns = "CLOUD_DNS"
  }

  # Dataplane V2の利用
  datapath_provider = "ADVANCED_DATAPATH"

  deletion_protection = false
}

resource "google_container_node_pool" "primary_node_pool" {
  name       = "my-spot-node-pool"
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  node_count = 1

  # 自動スケーリングは無効化
  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "t2d-standard-2"
    spot         = true
    disk_size_gb = 20
    disk_type    = "pd-standard"

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }
}