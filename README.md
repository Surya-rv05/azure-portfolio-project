# 🌐 Azure Portfolio — Project 1

![Deploy Portfolio to Azure](https://github.com/Surya-rv05/azure-portfolio-project/actions/workflows/deploy.yml/badge.svg)

> Personal portfolio website deployed on Microsoft Azure with full CI/CD automation and Infrastructure as Code.

## 🔗 Live Demo
👉 **[https://stvzg6u3gi2zmok.z30.web.core.windows.net/](https://stvzg6u3gi2zmok.z30.web.core.windows.net/)**

---

## 🏗️ Architecture

```
Developer pushes code to GitHub
              ↓
GitHub Actions Pipeline triggers
              ↓
Authenticates to Azure via Service Principal
              ↓
Uploads files to Azure Blob Storage ($web container)
              ↓
Website live at Azure Static Website URL
```

---

## ⚙️ Tech Stack

| Layer | Technology |
|---|---|
| Infrastructure | Azure Bicep (IaC) |
| Hosting | Azure Blob Storage (Static Website) |
| CI/CD | GitHub Actions |
| Security | HTTPS enforced, TLS 1.2, Service Principal |
| Source Control | Git + GitHub |

---

## 🚀 CI/CD Pipeline

Every push to `main` branch automatically:

1. 📥 Checks out the latest code
2. 🔐 Logs into Azure using GitHub Secrets
3. ⚙️ Enables static website hosting
4. 🚀 Uploads website files to Azure Blob Storage
5. 🌐 Prints the live URL in pipeline logs

**Zero manual deployments — everything is automated.**

---

## 📁 Project Structure

```
azure-portfolio-project/
├── infra/
│   └── main.bicep          # Azure infrastructure as code
├── src/
│   └── index.html          # Portfolio website
├── .github/
│   └── workflows/
│       └── deploy.yml      # GitHub Actions CI/CD pipeline
└── README.md
```

---

## 🛠️ Infrastructure (Bicep)

Resources provisioned via code:

- **Azure Storage Account** — hosts the static website
  - Standard LRS replication
  - HTTPS only enforced
  - TLS 1.2 minimum
  - Static website hosting enabled

---

## 🔐 Security Highlights

- ✅ HTTPS enforced — HTTP traffic blocked
- ✅ TLS 1.2 minimum version
- ✅ Azure credentials stored in GitHub Secrets — never in code
- ✅ Service Principal with least privilege (Contributor on Resource Group only)
- ✅ No secrets or credentials committed to repository

---

## 🏃 How to Deploy This Yourself

### Prerequisites
- Azure CLI installed
- Azure account
- GitHub account

### Steps

**1. Clone the repo**
```bash
git clone https://github.com/Surya-rv05/azure-portfolio-project.git
cd azure-portfolio-project
```

**2. Login to Azure**
```bash
az login
```

**3. Create Resource Group**
```bash
az group create --name rg-portfolio-dev --location southindia
```

**4. Deploy Infrastructure**
```bash
az deployment group create --resource-group rg-portfolio-dev --template-file infra/main.bicep
```

**5. Enable Static Website and Upload**
```bash
az storage blob service-properties update --account-name YOUR_STORAGE_NAME --static-website --index-document index.html
az storage blob upload --account-name YOUR_STORAGE_NAME --container-name '$web' --name index.html --file src/index.html --content-type text/html
```

**6. Add GitHub Secrets**
- `AZURE_CREDENTIALS` — Service Principal JSON
- `STORAGE_ACCOUNT_NAME` — Your storage account name

**7. Push to main — pipeline auto-deploys!**

---

## 📚 Technical Highlights

- Production-grade Azure infrastructure provisioned via **Bicep** IaC
- **Azure Blob Storage** static website hosting with HTTPS enforcement
- Multi-stage **GitHub Actions CI/CD** pipelines with automated deployment
- Secure **Azure authentication** using Service Principal with least-privilege RBAC
- Conventional commit workflows with proper **Git branching strategies**

---

## 🎯 Related Projects

| Project | Description | Status |
|---|---|---|
| **01 — Portfolio Site** | Azure Blob Storage + Bicep + GitHub Actions | ✅ Live |
| 02 — Microservices on AKS | Terraform + Docker + Kubernetes + ArgoCD | 🔨 Building |
| 03 — DevSecOps Pipeline | Trivy + tfsec + Gitleaks + Defender | 📅 Planned |
| 04 — Lakehouse Platform | Databricks + Delta Lake + Synapse + Power BI | 📅 Planned |

---

*Built with ❤️ on Microsoft Azure | Surya — Azure DevOps & Data Engineer*