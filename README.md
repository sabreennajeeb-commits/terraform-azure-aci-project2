<img width="470" height="316" alt="Screenshot 2026-06-14 194754" src="https://github.com/user-attachments/assets/ef3eebe0-dbf2-4196-b3f2-ebb315be240a" />
<img width="470" height="316" alt="Screenshot 2026-06-14 194754" src="https://github.com/user-attachments/assets/56536be8-c0ed-460e-9b1c-f3478df2d0cd" />
# Project 2: Infrastructure as Code with Terraform and Azure ACI

## Author names and student IDs
Sabreen Ashraf Alzwi – Student ID: [4836]
Retaj Abraheem ben fadhl  – Student ID: [4804]
Rahaf Gadri Mohammed  – Student ID: [4872]


## Project title and description
CloudScale is a growing startup that needs to deploy a containerized web
application to Microsoft Azure without managing virtual machines.
The project was implemented using Azure Container Instances, Docker,
Terraform, Azure Storage, and GitHub Actions.
The implemented solution includes:
• A custom nginx-based Docker image displaying the names of Sabreen,
  Retaj, and Rahaf.
• A public Docker image published to Docker Hub under:
  rahafmohammed1/cloudscale-project2:v2
• Terraform configuration that provisions an Azure Resource Group and
  an Azure Container Instance with a public IP address and DNS label.
• An Azure Storage Account used as a remote backend for the Terraform
  state file.
• A GitHub Actions CI/CD workflow that runs Terraform Plan on pull
  requests and Terraform Apply on pushes to the main branch.
• A manual approval gate using the GitHub production environment.
• Azure authentication using a Service Principal stored securely in
  GitHub Secrets.


## Architecture diagram showing Docker + Terraform + Azure (all project resources and components)

Architecture 
+----------------------------------+
| Developers                       |
| Sabreen, Retaj, and Rahaf        |
+----------------+-----------------+
                 |
                 | git push / Pull Request
                 v
+----------------------------------+
| GitHub Repository                |
| terraform-azure-aci-project2     |
+----------------+-----------------+
                 |
      +----------+-----------+
      |                      |
      v                      v
+-------------------+  +--------------------------+
| Terraform Plan    |  | Manual Approval Gate     |
| Pull Request Job  |  | production environment   |
+-------------------+  +-------------+------------+
                                    |
                                    | approved
                                    v
                         +--------------------------+
                         | Terraform Apply          |
                         | GitHub Actions           |
                         +-------------+------------+
                                       |
                                       v
+------------------------+    +--------------------------------------+
| Docker Hub             |--->| Microsoft Azure                      |
| rahafmohammed1/        |    | Resource Group                       |
| cloudscale-project2:v2 |    | Azure Container Instance             |
+------------------------+    | Public IP + DNS + Port 80            |
                              | Azure Storage remote backend         |
                              +------------------+-------------------+
                                                 |
                                                 v
                                      +----------------------+
                                      | End User Web Browser |
                                      +----------------------+


## Docker image build and push instructions
docker build --no-cache -t rahafmohammed1/cloudscale-project2:v2 .
Push to Docker Hub
docker push rahafmohammed1/cloudscale-project2:v2




##Terraform setup instructions
terraform --version 


##GitHub Actions workflow explanation
GitHub Actions Workflow Explanation 
1. Terraform Plan
The Terraform Plan job runs whenever a Pull Request is opened or updated
against the main branch.

The job performs the following operations:

1. Checks out the repository.
2. Authenticates to Microsoft Azure.
3. Installs Terraform.
4. Initializes the Terraform remote backend.
5. Checks Terraform formatting.
6. Validates the Terraform configuration.
7. Runs Terraform Plan.

2. Terraform Apply
The Terraform Apply job runs when changes are pushed or merged into the
main branch.

The job targets the production GitHub Environment. Therefore, it enters
a waiting state and does not begin until an authorized reviewer manually
approves the deployment.

After approval, the workflow runs:

terraform apply -auto-approve





##Step-by-step detailed solution (same as lab file)
Step-by-Step Detailed Solution 
Step 1: Install and Verify the Required Tools
git --version
docker --version
az --version
terraform --version
Expected result:
Each command displays an installed version without an error.
Step 2: Create and Test the Docker Application
Step 2.1 – Create index.html
<!DOCTYPE html>
<html>
<head>
    <title>CloudScale Project 2</title>
</head>
<body>
    <h1>Hello from CloudScale!</h1>
    <h2>Infrastructure as Code with Terraform and Azure ACI</h2>
    <p>Prepared by: Sabreen, Ritaj, and Rahaf</p>
</body>
</html>
Step 2.2 – Create Dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
Step 2.3 – Build the Docker Image
docker build --no-cache -t rahafmohammed1/cloudscale-project2:v2 .
Step 2.4 – Run Locally
docker run --rm -p 8082:80 rahafmohammed1/cloudscale-project2:v2
Step 2.5 – Push to Docker Hub
docker login
docker push rahafmohammed1/cloudscale-project2:v2
Step 3: Create and Configure the GitHub Repository
Step 3.1 – Create the Public Repository
Repository name:
terraform-azure-aci-project2
Step 3.2 – Clone the Repository
git clone https://github.com/sabreennajeeb-commits/terraform-azure-aci-project2.git
Step 3.3 – Initial Commit
git add .
git commit -m "Initial project structure with Docker web app"
git push origin main
Step 3.4 – Add Collaborators
Settings → Collaborators → Add people
Step 3.5 – Create Branches
git checkout -b retaj
git checkout -b rahaf
Step 4: Create the Terraform Remote Backend
Step 4.1 – Azure Login
az login
Step 4.2 – Create Resource Group
az group create `
  --name sabreen-ritaj-rahaf-tfstate-rg `
  --location swedencentral
Step 4.3 – Create Storage Account
az storage account create `
  --name srrtfstate89165 `
  --resource-group sabreen-ritaj-rahaf-tfstate-rg `
  --location swedencentral `
  --sku Standard_LRS
Step 4.4 – Create State Container
az storage container create `
  --name tfstate `
  --account-name srrtfstate89165 `
  --auth-mode login
Step 5: Create Terraform Files

File
Purpose 
providers.tf 
AzureRM provider and remote backend 
variables.tf 
Project configuration variables 
main.tf 
Resource Group and Container Instance 
outputs.tf 
Resource names, IP and FQDN 
.gitignore 
Excludes Terraform state and temporary files 





Final Docker Image Variable
variable "docker_image" {
  description = "Docker Hub image used by Azure Container Instance"
  type        = string
  default     = "rahafmohammed1/cloudscale-project2:v2"
}
Step 6: Initialize and Validate Terraform
Step 6.1
terraform init -reconfigure
Step 6.2
terraform fmt
Step 6.3
terraform validate
Expected:
Success! The configuration is valid.
Step 6.4
terraform plan
Initial expected result:
Plan: 2 to add, 0 to change, 0 to destroy.
Step 7: Configure Azure Provider Registration
Step 7.1
The first deployment failed because the subscription was not registered for Azure Container Instances.
Step 7.2
az provider register --namespace Microsoft.ContainerInstance


Step 7.3
az provider show `
  --namespace Microsoft.ContainerInstance `
  --query "registrationState" `
  -o table
Expected:
Registered
Step 8: Import the Existing Resource Group
The first Apply created the Resource Group before failing. It was imported into the remote state.
terraform import azurerm_resource_group.project_rg `
"/subscriptions/[SUBSCRIPTION-ID]/resourceGroups/sabreen-ritaj-rahaf-proj2-aci-rg"
Expected:
Import successful!
Step 9: Configure Azure Authentication
Step 9.1 – Create Service Principal
az ad sp create-for-rbac `
  --name "project2-github-actions" `
  --role contributor `
  --scopes /subscriptions/[SUBSCRIPTION-ID] `
  --sdk-auth
Step 9.2 – Create GitHub Secret
Settings → Secrets and variables → Actions → New repository secret
Name:
AZURE_CREDENTIALS
The secret value is the Azure Service Principal JSON output.

Step 10: Configure GitHub Actions
Workflow:
.github/workflows/terraform.yml
Pipeline logic:
Pull Request to main:
Terraform Init → Format → Validate → Plan

Push to main:
Wait for manual approval → Terraform Apply

Step 11: Configure Manual Approval
Settings → Environments → production
Then 
Enable Required Reviewers
Add Sabreen, Retaj, and Rahaf
Save protection rules
Step 12: Pull Request Collaboration
Retaj Branch
Terraform configuration was committed and pushed from the retaj branch.
A Pull Request was opened and merged into main.
Rahaf Branch
The GitHub Actions workflow was committed and pushed from the rahaf branch.
A Pull Request was opened. Terraform Plan completed successfully, and the
Pull Request was merged into main.
Step 13: Production Deployment
After the changes were pushed to main, the Terraform Apply job entered
the Waiting state.

An authorized team member selected:

Review deployments → production → Approve and deploy
Expected:
Terraform Apply completed successfully.
Step 14: Update the Docker Image
The initial image displayed the Apache default page.
A new nginx image was built:
docker build --no-cache -t rahafmohammed1/cloudscale-project2:v2 .
docker push rahafmohammed1/cloudscale-project2:v2
Terraform was updated to use v2.
Expected plan:
image = "...:latest" → "...:v2"
After approval, Terraform replaced the Container Instance and deployed the corrected application.
Step 15: Verify the Deployment
Application:
http://sabreen-ritaj-rahaf-project2.swedencentral.azurecontainer.io
Azure Portal verification:
Resource Group:
sabreen-ritaj-rahaf-proj2-aci-rg

Container Instance:
sabreen-ritaj-rahaf-proj2-aci

Status:
Running

Region:
Sweden Central



##Repository Link
https://github.com/sabreennajeeb-commits/terraform-azure-aci-project2


---

## 📸 Project Screenshots

### 1. Docker Image Build
![Docker Build](images/Screenshot%202026-06-14%20194754.png)

### 2. Docker Push to Docker Hub
![Docker Push](images/Screenshot%202026-06-14%20195448.png)

### 3. Terraform Plan Output
![Terraform Plan](images/Screenshot%202026-06-14%20195519.png)

### 4. Terraform Apply Output
![Terraform Apply](images/Screenshot%202026-06-14%20195632.png)

### 5. GitHub Actions (Pull Request / Plan)
![GitHub Actions Plan](images/Screenshot%202026-06-14%20195644.png)

### 6. GitHub Actions (Manual Approval / Apply)
![GitHub Actions Apply](images/Screenshot%202026-06-14%20195709.png)

### 7. Final Deployed Application & Azure Portal
![Deployed App and Azure Portal](images/Screenshot%202026-06-14%20195730.png)

---






