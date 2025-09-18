# my_infra

このリポジトリは、foobarサービスのためのインフラストラクチャをコードで管理します。

## 前提条件

*   [Terraform](https://www.terraform.io/downloads.html) v1.0.0 以降
*   [FluxCD](https://fluxcd.io/)
*   設定済みのAWS認証情報

## 利用方法

### Terraform

インフラストラクチャの変更を適用するには：

```bash
cd terraform/
terraform init
terraform plan
terraform apply
```

### Kubernetes (Flux GitOps)

このリポジトリのKubernetesマニフェストは、FluxによるGitOpsワークフローを通じてクラスタに自動的に同期されます。

`k8s`ディレクトリ内のマニフェストファイルを変更し、Gitリポジトリにプッシュすることで、変更が自動的に適用されます。手動での`kubectl apply`は不要です。

## ディレクトリ構成

```
.
├── README.md
├── k8s
│   └── service.yml
└── terraform
    ├── main.tf
    └── variables.tf
```

## コントリビューション

詳細は`CONTRIBUTING.md`を参照してください。
