﻿param(

    [parameter]
    [string]$SentinelWorkspaceId,

    [parameter]
    [string]$SentinelWorkspaceKey

)


##############################################################
#  Dual-home Microsoft Monitoring Agent for Azure Sentinel
##############################################################
if($SentinelWorkspaceId -and $SentinelWorkspaceKey)
{
    $mma = New-Object -ComObject 'AgentConfigManager.MgmtSvcCfg'
    $mma.AddCloudWorkspace($SentinelWorkspaceId, $SentinelWorkspaceKey)
    $mma.ReloadConfiguration()
}


##############################################################
#  Run the Virtual Desktop Optimization Tool (VDOT)
##############################################################
# https://github.com/The-Virtual-Desktop-Team/Virtual-Desktop-Optimization-Tool

# Extract VDOT from ZIP archive
Expand-Archive -LiteralPath $ZIP -Force -ErrorAction 'Stop'
    
# Run VDOT
& .\VDOT\Virtual-Desktop-Optimization-Tool-main\Windows_VDOT.ps1 -Optimizations All -AcceptEULA -Restart