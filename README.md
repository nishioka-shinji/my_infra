# my_infra Infrastructure Repository

このリポジトリは、foobarサービスのためのインフラストラクチャをコードで管理します。Terraform, Kubernetes (FluxCD), sopsを使用しています。

## 前提条件

作業を始める前に、以下のツールがインストールされていることを確認してください。

*   [Terraform](https://www.terraform.io/downloads.html)
*   [FluxCD](https://fluxcd.io/)
*   [sops](https://github.com/mozilla/sops)
*   設定済みのAWSおよびGCP認証情報

## ディレクトリ構成

このリポジトリのディレクトリ構成は以下の通りです。

```
.
├── AGENTS.md
├── README.md
├── k8s
│   └── gcp
│       ├── atlantis
│       ├── flux-system
│       └── kustomization.yaml
├── my_infra
│   └── README.md
├── renovate.json
├── sops
└── terraform
    └── gcp
        ├── 01-api
        ├── 02-network
        ├── 03-iam
        ├── cloud_storage
        ├── gke
        └── kms
```

詳細なファイルリストはリポジトリを参照してください。

## 利用方法

### Terraform

Terraformのコードは`terraform/gcp/`配下の各ディレクトリで管理されています。

インフラを変更する場合、対象のディレクトリに移動して`terraform`コマンドを実行してください。

**例: ネットワークの変更**
```bash
cd terraform/gcp/02-network/
terraform plan
terraform apply
```

**注意:** コードを変更した後は、`terraform fmt`を実行してフォーマットを整えてください。

### Kubernetes (Flux GitOps)

Kubernetesのマニフェストは`k8s/gcp/`配下で管理されており、Fluxによってクラスタと自動的に同期されます。

手動で`kubectl apply`を実行する必要はありません。Gitリポジトリに変更をプッシュすることで、自動的に反映されます。

### sops

暗号化された機密情報（Secret）はsopsで管理されています。

ファイルを編集する場合は、以下のコマンドを使用します。

```bash
sops k8s/gcp/atlantis/atlantis-github-secret.sops.yaml
```
