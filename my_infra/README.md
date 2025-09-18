# my_infra

このリポジトリは、foobarサービスのためのインフラストラクチャをコードで管理します。

## 前提条件

*   [Terraform](https://www.terraform.io/downloads.html) v1.0.0 以降
*   [FluxCD](https://fluxcd.io/)
*   [sops](https://github.com/mozilla/sops)
*   設定済みのAWS認証情報

## 利用方法

### Terraform

インフラストラクチャの変更を適用するには、対象クラスタのディレクトリに移動して実行します。

```bash
cd clusters/production/infrastructure/terraform
terraform init
terraform plan
terraform apply
```

### Kubernetes (Flux GitOps)

このリポジトリのKubernetesマニフェストは、FluxによってGitOpsワークフローを通じてクラスタに自動的に同期されます。

`clusters/production/apps`ディレクトリ配下のマニフェストファイルを変更し、Gitリポジトリにプッシュすることで、変更が自動的に適用されます。

### sops

暗号化されたSecretファイルを編集するには、`sops`コマンドを使用します。

```bash
sops clusters/production/apps/secrets/my-app-secrets.sops.yaml
```

## ディレクトリ構成

より現実的なGitOpsのディレクトリ構成例を以下に示します。

```
.
├── README.md
└── clusters
    └── production                      # 環境（クラスタ）ごと
        ├── flux-system                 # FluxCDのコアコンポーネント
        │   ├── gotk-components.yaml
        │   └── gotk-sync.yaml
        ├── infrastructure              # Terraformによるインフラ定義
        │   └── terraform
        │       ├── main.tf
        │       └── variables.tf
        └── apps                        # アプリケーションのマニフェスト
            ├── base
            │   └── my-app
            │       └── release.yaml
            └── secrets
                └── my-app-secrets.sops.yaml
```
