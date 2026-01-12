# Aviatrix Control Plane CloudShell Launcher

This directory contains a PowerShell script that provides a user-friendly wrapper around the [terraform-aviatrix-azure-controlplane](../terraform-aviatrix-azure-controlplane-main/) Terraform module. It's designed to guide users through deploying a complete Aviatrix control plane in Azure without requiring deep Terraform knowledge.

## Who should (not) use it?

### ✅ **You SHOULD use this if:**
- You want to quickly deploy Aviatrix with minimal setup complexity
- You prefer a simple, guided installation process without Terraform expertise
- You don't need to manage infrastructure changes after initial deployment
- You're comfortable with a "deploy and forget" approach
- You want to get started quickly without learning Terraform specifics
- You need a one-time deployment (for any environment: production, staging, demos, or testing)

### ❌ **You should NOT use this if:**
- You need to manage ongoing infrastructure changes and updates through IaC
- You want to maintain Terraform state for future modifications
- You need to integrate with existing Terraform workflows or CI/CD pipelines
- You require repeatable, automated deployments across multiple environments
- You want to track infrastructure changes over time
- You plan to make frequent configuration changes to the deployment
- You need infrastructure-as-code practices with version control

### 🔧 **Alternative: Use the Terraform Module Directly**
If this script doesn't meet your needs, use the underlying [terraform-aviatrix-azure-controlplane](../terraform-aviatrix-azure-controlplane-main/) Terraform module directly:
- Full control over Terraform state management
- Integration with existing Terraform workflows
- Version control and infrastructure-as-code practices
- Customizable configuration beyond script parameters
- Suitable for CI/CD pipelines and automated deployments

## What Gets Deployed

The script deploys and configures:

- **Aviatrix Controller Azure VM** - The main control plane virtual machine
- **Controller initialization** - Automatic setup and configuration
- **Azure AD App Registration** - Service principal with required permissions
- **Azure subscription onboarding** - Connects your Azure subscription to the controller
- **Optional CoPilot deployment** - Analytics and monitoring platform
- **Network Security Groups** - Properly configured network access controls
- **Azure Marketplace agreement** - Accepts terms for Aviatrix products

## Prerequisites

- **Azure Cloud Shell access** (recommended) or local Azure CLI setup
- **Azure CLI authentication** with sufficient permissions
- **Azure RBAC permissions** to create resources and service principals
- **Valid Aviatrix customer license ID**
- **Azure subscription** with appropriate quotas for VM deployment

### Required Azure Permissions

Your Azure user/role needs the following permissions:
- Virtual Machine Contributor (for creating VMs and related resources)
- Network Contributor (for VNet, subnet, and NSG management)
- Application Administrator or Global Administrator (for App Registration)
- User Access Administrator (for role assignments)
- Marketplace Administrator (for accepting marketplace terms)

## Quick Start

### Option 1: Interactive Mode (Recommended)
1. Open the Azure Portal
2. Launch an Azure Cloud Shell in Powershell mode
3. Execute the commands below, replacing with your configuration details

```powershell
iex (irm https://raw.githubusercontent.com/terraform-aviatrix-modules/terraform-aviatrix-azure-controlplane/refs/heads/main/cloudshell/deploy-aviatrix-controlplane.ps1)
```

### Option 2: Automated Mode
1. Open the Azure Portal
2. Launch an Azure Cloud Shell in Powershell mode
3. Execute the commands below, replacing with your configuration details

```powershell
# Download the deployment script
irm https://raw.githubusercontent.com/terraform-aviatrix-modules/terraform-aviatrix-azure-controlplane/refs/heads/main/cloudshell/deploy-aviatrix-controlplane.ps1 -OutFile deploy-aviatrix-controlplane.ps1

# Execute the deployment with your configuration
./deploy-aviatrix-controlplane.ps1 `
    -DeploymentName "my-avx-ctrl" `
    -Location "East US" `
    -AdminEmail "admin@company.com" `
    -AdminPassword "MySecure123!" `
    -CustomerID "aviatrix-abc-123456"
```

### Option 3: launch.aviatrix.com
When cloudshell commands are assembled from launch.aviatrix.com the following command is used for deployment.

1. Open the Azure Portal
2. Launch an Azure Cloud Shell in Powershell mode
3. Execute the commands below, replacing with your configuration details

```powershell
# Download the deployment script
irm https://raw.githubusercontent.com/terraform-aviatrix-modules/terraform-aviatrix-azure-controlplane/refs/heads/main/cloudshell/deploy-aviatrix-controlplane.ps1 -OutFile deploy-aviatrix-controlplane.ps1

# Execute the deployment with your configuration
./deploy-aviatrix-controlplane.ps1 `
    -DeploymentName "<name>" `
    -Location "<location>" `
    -AdminEmail "<admin_email>" `
    -AdminPassword "<admin_password>" `
    -CustomerID "<customer_id>" `
    -AdditionalManagementIPs "<user_public_ip>/32" `
    -IncludeCopilot $true
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
