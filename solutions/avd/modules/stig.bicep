param _artifactsLocation string
@secure()
param _artifactsLocationSasToken string
param AutomationAccountName string
param ConfigurationName string
param Location string
param Timestamp string


var Modules = [
  {
    name: 'AccessControlDSC'
    uri: 'https://www.powershellgallery.com/api/v2/package/AccessControlDSC/1.4.1'
  }
  {
    name: 'AuditPolicyDsc'
    uri: 'https://www.powershellgallery.com/api/v2/package/AuditPolicyDsc/1.4.0.0'
  }
  {
    name: 'AuditSystemDsc'
    uri: 'https://www.powershellgallery.com/api/v2/package/AuditSystemDsc/1.1.0'
  }
  {
    name: 'CertificateDsc'
    uri: 'https://www.powershellgallery.com/api/v2/package/CertificateDsc/5.0.0'
  }
  {
    name: 'ComputerManagementDsc'
    uri: 'https://www.powershellgallery.com/api/v2/package/ComputerManagementDsc/8.4.0'
  }
  {
    name: 'FileContentDsc'
    uri: 'https://www.powershellgallery.com/api/v2/package/FileContentDsc/1.3.0.151'
  }
  {
    name: 'GPRegistryPolicyDsc'
    uri: 'https://www.powershellgallery.com/api/v2/package/GPRegistryPolicyDsc/1.2.0'
  }
  {
    name: 'nx'
    uri: 'https://www.powershellgallery.com/api/v2/package/nx/1.0'
  }
  {
    name: 'PSDscResources'
    uri: 'https://www.powershellgallery.com/api/v2/package/PSDscResources/2.12.0.0'
  }
  {
    name: 'SecurityPolicyDsc'
    uri: 'https://www.powershellgallery.com/api/v2/package/SecurityPolicyDsc/2.10.0.0'
  }
  {
    name: 'SqlServerDsc'
    uri: 'https://www.powershellgallery.com/api/v2/package/SqlServerDsc/13.3.0'
  }
  {
    name: 'WindowsDefenderDsc'
    uri: 'https://www.powershellgallery.com/api/v2/package/WindowsDefenderDsc/2.1.0'
  }
  {
    name: 'xDnsServer'
    uri: 'https://www.powershellgallery.com/api/v2/package/xDnsServer/1.16.0.0'
  }
  {
    name: 'xWebAdministration'
    uri: 'https://www.powershellgallery.com/api/v2/package/xWebAdministration/3.2.0'
  }
  {
    name: 'PowerSTIG'
    uri: 'https://www.powershellgallery.com/api/v2/package/PowerSTIG/4.10.1'
  }
]


@batchSize(1)
resource modules 'Microsoft.Automation/automationAccounts/modules@2019-06-01' = [for item in Modules: {
  name: '${AutomationAccountName}/${item.name}'
  location: Location
  properties: {
    contentLink: {
      uri: item.uri
    }
  }
}]

resource configuration 'Microsoft.Automation/automationAccounts/configurations@2019-06-01' = {
  name: '${AutomationAccountName}/${ConfigurationName}'
  location: Location
  properties: {
    source: {
      type: 'uri'
      value: '${_artifactsLocation}Windows10.ps1${_artifactsLocationSasToken}'
      version: Timestamp
    }
    parameters: {}
    description: 'Hardens the VM using the Azure STIG Template'
  }
  dependsOn: [
    modules
  ]
}

resource compilationJob 'Microsoft.Automation/automationAccounts/compilationjobs@2019-06-01' = {
  name: '${AutomationAccountName}/${guid(deployment().name)}'
  location: Location
  properties: {
    configuration: {
      name: ConfigurationName
    }
  }
  dependsOn: [
    modules
    configuration
  ]
}
