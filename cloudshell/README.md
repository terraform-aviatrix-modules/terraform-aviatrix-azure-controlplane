# Aviatrix Control Plane CloudShell Launcher

A PowerShell script that provides a user-friendly wrapper around the [terraform-aviatrix-azure-controlplane](../terraform-aviatrix-azure-controlplane-main/) Terraform module for deploying Aviatrix control plane infrastructure in Azure.

## 🚀 Quick Start - Two-Line Deployment

1. Open the Azure Portal
2. Launch an Azure Cloud Shell in Powershell mode
3. Execute the commands below, replacing with your configuration details

```powershell
irm https://raw.githubusercontent.com/terraform-aviatrix-modules/terraform-aviatrix-azure-controlplane/refs/heads/main/ps-cloudshell-launcher/deploy-aviatrix-controlplane.ps1 -OutFile deploy-aviatrix-controlplane.ps1
./deploy-aviatrix-controlplane.ps1 -DeploymentName "my-avx-ctrl" -Location "East US" -AdminEmail "admin@company.com" -AdminPassword "MySecure123!" -CustomerID "aviatrix-abc-123456"
```

### One-Line Interactive Mode
For interactive prompts, you can still use the one-line approach:

```powershell
iex (irm https://raw.githubusercontent.com/terraform-aviatrix-modules/terraform-aviatrix-azure-controlplane/refs/heads/main/ps-cloudshell-launcher/deploy-aviatrix-controlplane.ps1)
```

## 📋 Prerequisites

- **Azure Cloud Shell** (PowerShell mode required)
- **Azure CLI** authenticated (automatic in Cloud Shell)
- **Valid Aviatrix license** (customer ID)
- **Appropriate Azure permissions** (Contributor role or equivalent)
- **Azure AD app registration permissions** (Global Administrator, Application Administrator, or equivalent role)
- **Azure Marketplace access** (script will automatically check and accept marketplace agreements as needed)

## 🎯 What This Script Deploys

### Core Components (Always Deployed)
- ✅ **Aviatrix Controller VM** - The main control plane
- ✅ **Controller Initialization** - Automated setup and configuration  
- ✅ **Azure AD App Registration** - For API access permissions
- ✅ **Azure Account Onboarding** - Connects your subscription to the controller
- ✅ **Network Security Groups** - Secure access from your IP only
- ✅ **Azure Marketplace Agreements** - Automatic checking and acceptance of terms as needed

### Optional Components
- 🔹 **Aviatrix CoPilot** - Advanced analytics and monitoring platform

## 📖 Usage Examples

### Interactive Mode (Recommended for First-Time Users)
```powershell
./deploy-aviatrix-controlplane.ps1
```
The script will prompt you for all required information with helpful guidance.

### Automated Mode (For Experienced Users)
```powershell
./deploy-aviatrix-controlplane.ps1 `
  -DeploymentName "my-avx-ctrl" `
  -Location "East US" `
  -AdminEmail "admin@company.com" `
  -AdminPassword "MySecure123!" `
  -CustomerID "aviatrix-abc-123456"
```

### With Additional Management Access
```powershell
./deploy-aviatrix-controlplane.ps1 `
  -DeploymentName "my-avx-ctrl" `
  -Location "East US" `
  -AdminEmail "admin@company.com" `
  -AdminPassword "MySecure123!" `
  -CustomerID "aviatrix-abc-123456" `
  -AdditionalManagementIPs "192.168.1.100,10.0.0.0/24,203.0.113.50"
```

### Deploy with CoPilot
```powershell
./deploy-aviatrix-controlplane.ps1 `
  -DeploymentName "my-avx-ctrl" `
  -IncludeCopilot $true `
  -SkipConfirmation
```

### Planning Mode (Review Before Deploy)
```powershell
./deploy-aviatrix-controlplane.ps1 `
  -TerraformAction "plan" `
  -DeploymentName "my-avx-ctrl"
```

### Destroy Deployment
```powershell
./deploy-aviatrix-controlplane.ps1 `
  -TerraformAction "destroy" `
  -DeploymentName "my-avx-ctrl"
```

## 🔧 Parameters Reference

| Parameter | Required | Description | Example |
|-----------|----------|-------------|---------|
| `DeploymentName` | No* | Unique name for deployment (3-20 chars) | `"my-avx-ctrl"` |
| `Location` | No* | Azure region | `"East US"` |
| `AdminEmail` | No* | Controller admin email | `"admin@company.com"` |
| `AdminPassword` | No* | Secure admin password | `"MySecure123!"` |
| `CustomerID` | No* | Aviatrix license ID | `"aviatrix-abc-123456"` |
| `IncludeCopilot` | No | Deploy CoPilot analytics | `$true` or `$false` |
| `IncomingMgmtCIDRs` | No | Your public IP/CIDR (auto-detected) | `"203.0.113.1"` |
| `AdditionalManagementIPs` | No | Additional IPs for controller access | `"192.168.1.100,10.0.0.0/24"` |
| `SkipConfirmation` | No | Skip interactive prompts | Switch parameter |
| `TerraformAction` | No | Terraform action | `"plan"`, `"apply"`, `"destroy"` |

*\* Required if not running in interactive mode*

## 🔒 Security Features

- **Enhanced IP Whitelisting**: Controller access restricted to CloudShell IP + additional management IPs
- **Flexible Access Control**: Support for individual IPs and CIDR blocks for team access
- **Secure Credentials**: Passwords handled securely with validation
- **Azure AD Integration**: Proper RBAC roles and permissions
- **HTTPS Only**: All web interfaces use SSL/TLS
- **Input Validation**: Comprehensive parameter validation

## ⏱️ Deployment Timeline

| Phase | Duration | Description |
|-------|----------|-------------|
| Prerequisites | 1-2 min | Terraform install, Azure auth check, marketplace verification |
| Terraform Plan | 1-2 min | Configuration validation |
| Infrastructure | 5-8 min | VM deployment, networking |
| Controller Init | 3-5 min | Software setup, API configuration |
| Account Onboarding | 1-2 min | Azure subscription connection |
| CoPilot (if enabled) | 3-5 min | Additional VM and configuration |
| **Total** | **10-15 min** | **Complete deployment** |

## 📊 Post-Deployment

### Accessing Your Controller
After successful deployment, you'll receive:
- **Controller URL**: `https://[controller-ip]`
- **Username**: `admin`
- **Password**: Your configured password
- **CoPilot URL**: `https://[copilot-ip]` (if deployed)

### Next Steps
1. Log in to the controller web interface
2. Explore the dashboard and verify account onboarding
3. Review the [Aviatrix Getting Started Guide](https://docs.aviatrix.com/StartUpGuides/aviatrix-cloud-controller-startup-guide.html)
4. Begin creating your multi-cloud network architecture

## 🛠️ Managing Your Deployment

### Terraform Files Location
All Terraform configuration is saved in: `./aviatrix-deployment/`

### Making Changes
```powershell
cd ./aviatrix-deployment
# Edit main.tf as needed
terraform plan
terraform apply
```

### Adding CoPilot Later
Re-run the script with `-IncludeCopilot $true` to add CoPilot to an existing deployment.

### Cleanup
```powershell
./deploy-aviatrix-controlplane.ps1 -TerraformAction destroy
```

## ❓ Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| "Not authenticated" | Run `az login` in Cloud Shell |
| "Azure AD permissions required" | Run `az login` again or ensure you have Application Administrator role |
| "Terraform not found" | Script auto-installs - ensure ~/bin is in PATH |
| "Invalid customer ID" | Contact Aviatrix support for license |
| "Password validation failed" | Use 8+ chars with letter+number+symbol |
| "Region not available" | Try different Azure region |
| "IP detection failed" | Manually specify `-IncomingMgmtCIDRs` parameter |
| "Marketplace agreement failed" | Ensure you have permissions to accept marketplace terms |

> **Note**: When using `-TerraformAction "destroy"`, the script automatically skips Azure AD permission checks and marketplace subscription verification since these are not needed for destroying existing resources.

### Getting Help
- **Aviatrix Documentation**: https://docs.aviatrix.com
- **Support Portal**: https://support.aviatrix.com
- **Community**: https://community.aviatrix.com

### Debug Mode
Add `-Verbose` to any command for detailed logging:
```powershell
./deploy-aviatrix-controlplane.ps1 -Verbose
```

## 🔄 Comparison with Terraform Module

This script wraps the [terraform-aviatrix-azure-controlplane](../terraform-aviatrix-azure-controlplane-main/) module and provides:

| Feature | Direct Terraform | This Script |
|---------|------------------|-------------|
| Terraform Knowledge Required | ✅ Required | ❌ Not needed |
| Azure CLI Setup | Manual | ✅ Automated |
| IP Detection | Manual | ✅ Automated |
| Marketplace Agreement Check | Manual | ✅ Automated |
| Input Validation | Limited | ✅ Comprehensive |
| Error Handling | Basic | ✅ User-friendly |
| Interactive Mode | No | ✅ Yes |
| One-line Deploy | No | ✅ Yes |

## 📝 Examples Directory

See the [examples](examples/) directory for additional deployment scenarios:
- Basic controller-only deployment
- Full stack with CoPilot
- Custom networking scenarios
- Multi-region deployments

## 📄 License

This script is provided under the same license as the Aviatrix Terraform modules. Use in accordance with your Aviatrix license agreement.
