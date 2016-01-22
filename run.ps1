param([string]$Company = "Company", [string]$ou = "bar")

# Get folder path of currenct script
$FolderPathOfCurrentScript = Split-Path -Parent $MyInvocation.MyCommand.Path
 
# Set current module path and create current module folder if it doesn't exist
$CurrentModulePath = $FolderPathOfCurrentScript + "\WindowsPowerShell\Modules\"


# Get default $PSModulePath and append $CurrentModulePath to $PSModulePath if $CurrentModulePath doesn't exist
if ([Environment]::GetEnvironmentVariable("PSModulePath").Contains($CurrentModulePath) -eq $false) {
    [Environment]::SetEnvironmentVariable("PSModulePath", ([Environment]::GetEnvironmentVariable("PSModulePath") + ';' + $CurrentModulePath))
}

Import-Module -Force -Name CreatingFolderForADUser -Verbose

New-FolderForADUser -Company $Company