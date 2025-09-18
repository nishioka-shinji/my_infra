# my_infra

このリポジトリは、foobarサービスのためのインフラストラクチャをコードで管理します。

## 前提条件

*   [Terraform](https://www.terraform.io/downloads.html) v1.0.0 以降
*   [FluxCD](https://fluxcd.io/)
*   [sops](https://github.com/mozilla/sops)
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

### sops

暗号化されたファイルを編集するには：

```bash
sops sops/secrets.yaml
```

## ディレクトリ構成

```
.
├── README.md
├── k8s
│   └── service.yml
├── sops
│   └── secrets.yaml
└── terraform
    ├── main.tf
    └── variables.tf
```
