# Azure Virtual Desktop Solution

[**Home**](../readme.md) | [**Features**](./features.md) | [**Design**](./design.md) | [**Prerequisites**](./prerequisites.md) | [**Post Deployment**](./post.md) | [**Troubleshooting**](./troubleshooting.md)

## Features

- [**FSLogix**](https://docs.microsoft.com/en-us/fslogix/overview) - deploys the required resources to enable FSLogix when using domain services, Azure AD DS or AD DS, with AVD:
  - Azure Storage Account or Azure NetApp Files with a fully configured file share
  - Management Virtual Machine with a Custom Script Extension to:
    - Domain joins the Storage Account or creates the AD connection on the Azure NetApp Account
    - Sets the required NTFS permissions for access to the file share
  - Custom Script Extension on Session Hosts to enable FSLogix with any container option using registry settings:
    - Profile Container
    - Office Container
    - Cloud Cache
  - [Service Endpoint for Azure Files](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-networking-overview#public-endpoint-firewall-settings) (Optional) - deploys the appropriate configuration on the Storage Account to enable a service endpoint.
  - [Private Endpoint for Azure Files](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-networking-overview#private-endpoints) (Optional) - deploys the requirements to enable private endpoints on the Azure Storage Accounts to improve performance and enhance security:
    - Private Endpoint on the Azure Storage Account
    - Private DNS Zone with an A record and Virtual Network Link
    - DNS Forwarder
- [**Scaling Automation**](https://docs.microsoft.com/en-us/azure/virtual-desktop/scaling-automation-logic-apps) - this feature is automatically deployed if a "pooled" host pool is selected. The feature requires the following resources:
  - Automation Account with a Managed Identity
    - Runbook
    - Variable
    - PowerShell Modules
  - Logic App
  - Contributor role assignment on the AVD resource groups, limiting the privileges the Automation Account has in your subscription
- [**Auto Increase Premium File Share Quota**](https://github.com/Azure-Samples/azure-files-samples/tree/master/autogrow-PFS-quota) - when Azure Files Premium is selected for FSLogix Storage, this feature is deployed automatically. This tool helps reduce cost by scaling the file share quota only when needed. The following resources will be deployed:
  - Logic App
  - Automation Account
    - Runbook
    - Webhook
    - Variable
- [**Start VM On Connect**](https://docs.microsoft.com/en-us/azure/virtual-desktop/start-virtual-machine-connect?tabs=azure-portal) (Optional) - deploys the required resources to enable the feature:
  - Role with appropriate permissions
  - Role assignment
  - Enables the feature on the AVD host pool
- **[Virtual Desktop Optimization Tool](https://github.com/The-Virtual-Desktop-Team/Virtual-Desktop-Optimization-Tool)** - removes unnecessary apps, services, and processes from Windows 10 or 11, improving performance and resource utilization.
- [**Monitoring**](https://docs.microsoft.com/en-us/azure/virtual-desktop/azure-monitor) (Optional) - deploys the required resources to enable the Insights workbook:
  - Log Analytics Workspace with the required Windows Events and Performance Counters.
  - Microsoft Monitoring Agent on the session hosts.
  - Diagnostic settings on the AVD host pool and workspace.
- [**GPU Drivers & Settings**](https://docs.microsoft.com/en-us/azure/virtual-desktop/configure-vm-gpu) - deploys the extension to install the graphics driver and creates the recommended registry settings when an appropriate VM size (Nv, Nvv3, Nvv4, or NCasT4_v3 series) is selected.
- [**BitLocker Encryption**](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/disk-encryption-overview) (Optional) - deploys the required resources & configuration to enable BitLocker encryption on the session hosts:
  - Key Vault with a Key Encryption Key
  - Azure Disk Encryption extension on the virtual machines
- [**Backups**](https://docs.microsoft.com/en-us/azure/backup/backup-overview) (Optional) - deploys the required resources to enable backups:
  - Recovery Services Vault
  - Backup Policy
  - Protection Container (File Share Only)
  - Protected Item
- [**Screen Capture Protection**](https://docs.microsoft.com/en-us/azure/virtual-desktop/screen-capture-protection) (Optional) - deploys the required registry setting on the AVD session hosts to enable the feature.
- [**Drain Mode**](https://docs.microsoft.com/en-us/azure/virtual-desktop/drain-mode) (Optional) - when enabled, the sessions hosts will be deployed in drain mode to ensure end users cannot access the host pool until operations is ready to allow connections.
- [**RDP ShortPath for Managed Networks**](https://docs.microsoft.com/en-us/azure/virtual-desktop/shortpath) (Optional) - deploys the requirements to enable RDP ShortPath for Managed Networks.
- [**SMB Multichannel**](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-smb-multichannel-performance) - Enables multiple connections to an SMB share.  This feature is only supported with Azure Files Premium.
- [**High Availability**](https://docs.microsoft.com/en-us/azure/virtual-machines/availability) (Optional) - allows the virtual machines to be deployed in either Availability Zones or Availability Sets, to provide a higher SLA for your solution.  This is only applicable to pooled host pools.  SLA: 99.99% for Availability Zones, 99.95% for Availability Sets.
- [**Security Technical Implementation Guides (STIG)**](https://public.cyber.mil/stigs/) (Optional) - deploys a Desired State Configuration configuration using Automation State Configuration to enforce and report on DISA STIG compliance. This is a common configuration for US federal government customers.
- [**Ephemeral OS Disks**](https://docs.microsoft.com/en-us/azure/virtual-machines/ephemeral-os-disks) - deploys the session hosts so that the resource or cache disk is used for the operating system. A disk resource will not be created. This is not a common scenario but it does provide cost savings for a solution that will keep the session hosts online 24/7 or if you plan to delete the session hosts until needed.
- **Validation** - based on the selections you choose for your solution, a deployment script will validate those options to ensure you are deploying a compliant configuration that follows Microsoft's best practices.
