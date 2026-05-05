## 🔄 Architecture Flow Explanation (GitHub → AKS on Azure)

<img width="618" height="821" alt="image" src="https://github.com/user-attachments/assets/8ab2f3ef-fd5b-486f-a87f-edf98de7fbb2" />


### 1️⃣ Developer commits code
The process starts when a developer pushes code or triggers the workflow manually in the GitHub repository.

This includes changes to:
- main.bicep
- modules (aks.bicep)
- environment parameter files (dev/test/prod)

---

### 2️⃣ GitHub Repository triggers workflow
The commit or manual trigger activates the GitHub Actions pipeline defined in:

.github/workflows/deploy-aks.yml

This pipeline orchestrates the full infrastructure deployment process.

---

### 3️⃣ CI/CD pipeline execution (GitHub Actions)

The pipeline runs the following steps in sequence:

#### 🧱 Step 1: Bicep Build
- Compiles Bicep files into ARM JSON
- Validates syntax and structure

#### 🧪 Step 2: Validate
- Ensures template correctness
- Detects issues before deployment

#### 👀 Step 3: What-If Deployment
- Simulates changes in Azure
- Shows what will be created, modified, or deleted
- Prevents accidental infrastructure changes

#### 🚀 Step 4: Deploy
- Deploys resources to Azure if all checks pass
- Targets selected environment (dev/test/prod)

---

### 4️⃣ Authentication (Secure access to Azure)
GitHub Actions uses a Service Principal stored in GitHub Secrets:

- AZURE_CLIENT_ID  
- AZURE_TENANT_ID  
- AZURE_SUBSCRIPTION_ID  

No credentials are stored in code.

---

### 5️⃣ Environment selection
Supports multiple environments:

- dev → development AKS cluster  
- test → QA / validation cluster  
- prod → production cluster  

Each uses its own parameter file:

infra/params/dev.bicepparam  
infra/params/test.bicepparam  
infra/params/prod.bicepparam  

---

### 6️⃣ Azure Resource Deployment

Once deployment starts, Azure provisions:

- Resource Group  
- Azure Kubernetes Service (AKS)  
- System Node Pool  
- Managed Identity  

---

### 7️⃣ Final Output

After successful deployment:

- AKS cluster is created
- Node pool is ready
- Identity is attached
- Cluster is ready for workloads (apps, Helm, CI/CD pipelines)

---

## 🧠 Summary (One Line)

GitHub Actions uses Bicep to validate, preview (What-If), and deploy AKS into Azure securely using Service Principal authentication across multiple environments.
