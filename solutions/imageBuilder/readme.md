# Azure Image Builder

This solution will deploy all the resources needed to build an image with Azure Image Builder.  The Image Template is currently configured to add Microsoft Teams, reboot, and update the operating system.  The deployment will store the image in an Azure Compute Gallery.

## Prerequisites

Refer to the official Azure Image Builder Docs page for the current prerequisites: [https://docs.microsoft.com/en-us/azure/virtual-machines/image-builder-overview](https://docs.microsoft.com/en-us/azure/virtual-machines/image-builder-overview)

## Deployment Options

### Azure Portal

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fjamasten%2FAzure%2Fmaster%2Fsolutions%2FimageBuilder%2Fsolution.json)
[![Deploy to Azure Gov](https://aka.ms/deploytoazuregovbutton)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fjamasten%2FAzure%2Fmaster%2Fsolutions%2FimageBuilder%2Fsolution.json)

### PowerShell

````powershell
New-AzDeployment `
    -Location '<Azure location>' `
    -TemplateFile 'https://github.com/jamasten/Azure/blob/master/solutions/imageBuilder/solution.json' `
    -Verbose
````

### Azure CLI

````cli
az deployment sub create \
    --location '<Azure location>' \
    --template-uri 'https://github.com/jamasten/Azure/blob/master/solutions/imageBuilder/solution.json'
````
