# Azure Virtual Desktop Solution

[**Home**](../../readme.md) | [**Features**](../features.md) | [**Design**](../design.md) | [**Prerequisites**](../prerequisites.md) | [**Post Deployment**](../post.md) | [**Troubleshooting**](../troubleshooting.md)

## Features

- [**Auto Increase Premium File Share Quota**](./autoIncreasePremiumFileShareQuota.md)
- [**Backups**](./backups.md)
- [**BitLocker Encryption**](./bitlocker.md)
- [**Drain Mode**](./drainMode.md)
- [**Ephemeral OS Disks**](./ephemeralOsDisk.md)
- [**FSLogix**](./fslogix.md)
- [**GPU Drivers & Settings**](./gpu.md)
- [**High Availability**](./highAvailability.md)
- [**Monitoring**](./monitoring.md)
- [**RDP ShortPath for Managed Networks**](./rdpShortPath.md)
- [**Scaling Automation**](./scalingAutomation.md)
- [**Screen Capture Protection**](./screenCaptureProtection.md)
- [**Security Technical Implementation Guides (STIG)**](./securityTechnicalImplementationGuides.md)
- [**SMB Multichannel**](./smbMultiChannel.md)
- [**Start VM On Connect**](./startVmOnConnect.md)
- [**Validation**](./validation.md)
- [**Virtual Desktop Optimization Tool**](./virtualDesktopOptimizationTool.md)

### Screen Capture Protection

This optional feature is deployed by configuring the required registry setting on the AVD session hosts.  When enabled screen captures and screen sharing will not work.

**Reference:** [Screen Capture Protection - Microsoft Docs](https://docs.microsoft.com/en-us/azure/virtual-desktop/screen-capture-protection)

**Deployed Resources:**

- CustomScriptExtension
