# GKEクラスタの構築
このドキュメントは、`terraform/gcp/gke/` 配下で管理されている、GKE (Google Kubernetes Engine) クラスタを構築するためのTerraformリソースの概要を説明します。

## 概要
このTerraform構成は、GCPプロジェクトにGKE Autopilotクラスタをデプロイします。クラスタが使用するネットワークリソース（VPC、サブネット）は、`terraform/gcp/02-network/` の状態ファイルをリモートで参照して設定されます。

## リソース関連図
```mermaid
graph TD
    subgraph "Terraform State"
        NetworkState[<fa:fa-file-code> terraform/gcp/02-network]
    end

    subgraph "GKE Cluster"
        GKE[<fa:fa-ship> GKE Autopilot Cluster<br>(my-autopilot-cluster)]
    end

    subgraph "Network Resources"
        VPC(VPC)
        Subnet(Subnet)
        PodsRange(Pods Range)
        ServicesRange(Services Range)
    end

    NetworkState -- "provides" --> VPC
    NetworkState -- "provides" --> Subnet
    Subnet -- "contains" --> PodsRange
    Subnet -- "contains" --> ServicesRange

    GKE -- "uses" --> VPC
    GKE -- "uses" --> Subnet
    GKE -- "uses ip from" --> PodsRange
    GKE -- "uses ip from" --> ServicesRange
```

## リソース詳細
### 1. GKEクラスタ (`gke.tf`)
- **リソース:** `google_container_cluster`
- **説明:** `my-autopilot-cluster` という名前のGKE Autopilotクラスタを作成します。Autopilotモードのため、ノードの管理はGCPに委任されます。
- **ネットワーク設定:** クラスタが使用するVPCとサブネット、およびPodとService用のセカンダリIPレンジは、`data.tf` を通じて取得したネットワークリソースの情報を参照しています。

### 2. ネットワークデータの参照 (`data.tf`)
- **データソース:** `terraform_remote_state`
- **説明:** `terraform/gcp/02-network` モジュールのTerraform状態ファイル（GCSバケットに保存）を読み込み、VPCやサブネットなどのネットワーク関連の出力値を取得します。これにより、インフラの疎結合が保たれます。

### 3. バックエンド設定 (`backend.tf`)
- **Terraformバックエンド:** GCS (Google Cloud Storage)
- **バケット:** `shinji-nishioka-test-terraform-state`
- **説明:** このGKEモジュールの状態ファイル (`.tfstate`) は、指定されたGCSバケットの `terraform/gcp/gke` プレフィックス配下に保存されます。
- **プロバイダ設定:** GCPプロジェクト `shinji-nishioka-test` とリージョン `asia-northeast2` が指定されています。
