Param(

    #The first node in the domain name (i.e. jasonmasten.com)
    [Parameter(Mandatory=$true)]
    [string]$Domain,

    #An abbreviated version of the domain name
    #Used for naming external resources (i.e. key vault, storage account, automation account)
    [Parameter(Mandatory=$true)]
    [string]$DomainAbbreviation,

    #An abbreviated version of the environment
    #d = development
    #p = production
    #t = test
    [Parameter(Mandatory=$true)]
    [ValidateSet("d", "p", "t")]
    [string]$Environment, 

    #Primary Azure Region
    [Parameter(Mandatory=$true)]
    [ValidateSet("eastus", "usgovvirginia")]
    [string]$Location,
  
    #Storage Account SKU: (p)remium or (s)tandard
    [Parameter(Mandatory=$true)]
    [ValidateSet("p", "s")]
    [string]$StorageType, 
    
    [parameter(Mandatory=$true)]
    [string]$SubscriptionId
)

#############################################################
# Authenticate to Azure
#############################################################
if(!(Get-AzSubscription | Where-Object {$_.Id -eq $SubscriptionId}))
{
    Connect-AzAccount `
        -Subscription $SubscriptionId `
        -UseDeviceAuthentication
}


#############################################################
# Set Subscription Context
#############################################################
if(!(Get-AzContext | Where-Object {$_.Subscription.Id -eq $SubscriptionId}))
{
    Set-AzContext -Subscription $SubscriptionId
}


#############################################################
# Variables
#############################################################
# Gets User Principal for Key Vault Access Policy
$UserObjectId = (Get-AzADUser | Where-Object {$_.UserPrincipalName -like "$((Get-AzContext).Account.Id.Split('@')[0])*"}).Id

# Sets user details for deployment name and Security Center contact
$Context = Get-AzContext
$Username = $Context.Account.Id.Split('@')[0]
$Email = $Context.Account.Id
$TimeStamp = Get-Date -F 'yyyyMMddhhmmss'
$Name =  $Username + '_' + $TimeStamp
$Credential = Get-Credential -Message 'Input Azure VM credentials'
$Locations = switch($Location)
{
    eastus {@('eastus','westus2')}
    usgovvirginia {@('usgovvirginia','usgovarizona')}
}
$LocationAbbreviations = switch($Location)
{
    eastus {@('eus','wus')}
    usgovvirginia {@('usv','usa')}
}
$AutomationLocations = switch($Location)
{
    eastus {@('eastus2','westus2')}
    usgovvirginia {@('usgovvirginia','usgovarizona')}
}


#############################################################
# Add Azure AD Connect Account
#############################################################
$UPN = 'adconnect@' + $Domain
$test = Get-AzADUser -UserPrincipalName $UPN -ErrorAction SilentlyContinue
if(!$test)
{
    New-AzADUser -DisplayName 'AD Connect' -UserPrincipalName $UPN -Password $Credential.Password -MailNickname 'ADConnect'
}


#############################################################
# Template Parameter Object
#############################################################
$Params = @{
    AutomationLocations = $AutomationLocations
    Domain = $Domain
    DomainAbbreviation = $DomainAbbreviation
    Environment = $Environment
    Locations = $Locations
    LocationAbbreviations = $LocationAbbreviations
    StorageType = $StorageType
    SecurityDistributionGroup = $Email
    UserObjectId = $UserObjectId
    Username = $Username
}
$Params.Add("VmPassword", $Credential.Password) # Secure Strings must use Add Method for proper deserialization
$Params.Add("VmUsername", $Credential.UserName) # Secure Strings must use Add Method for proper deserialization


#############################################################
# Deployment
#############################################################
try 
{
    New-AzSubscriptionDeployment `
        -Name $Name `
        -Location $Params.Locations[0] `
        -TemplateFile '.\subscription.json' `
        -TemplateParameterObject $Params `
        -ErrorAction Stop `
        -Verbose
}
catch 
{
    Write-Host "Deployment Failed: $Name"
    $_ | Select-Object *
}