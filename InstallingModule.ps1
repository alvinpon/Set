# Get folder path of currenct script
$FolderPathOfCurrentScript = Split-Path -Parent $MyInvocation.MyCommand.Path
 
# Set current module path and create current module folder if it doesn't exist
$CurrentModulePath = $FolderPathOfCurrentScript + "\WindowsPowerShell\Modules\"
if ((Test-Path -Path $CurrentModulePath -PathType Container) -eq $false) {
    New-Item -ItemType "directory" -Path $CurrentModulePath
}

# Get default $PSModulePath and append $CurrentModulePath to $PSModulePath if $CurrentModulePath doesn't exist
if ([Environment]::GetEnvironmentVariable("PSModulePath").Contains($CurrentModulePath) -eq $false) {
    [Environment]::SetEnvironmentVariable("PSModulePath", ([Environment]::GetEnvironmentVariable("PSModulePath") + ';' + $CurrentModulePath))
}

# Retrieve all moulde file paths
$ModuleFilePaths = Get-ChildItem -File -Path ($FolderPathOfCurrentScript + "\*.psm1")

# Create folder for each module and copy module file into folder if this folder doesn't exist and import module
foreach ($ModuleFilePath in $ModuleFilePaths) {
    $ModuleName = Split-Path -Leaf $ModuleFilePath
    $ModuleName = $ModuleName.Substring(0, $ModuleName.LastIndexOf('.'))
    
    if ((Test-Path -Path ($CurrentModulePath + $ModuleName) -PathType Container) -eq $false) {
        New-Item -ItemType "directory" -Path ($CurrentModulePath + $ModuleName)
    }
    Copy-Item $ModuleFilePath -Destination ($CurrentModulePath + $ModuleName + '\')
    Import-Module -Force -Name $ModuleName -Verbose
}