param(
    [System.Security.AccessControl.AccessControlType] $AccessControlType,
    [System.Security.AccessControl.FileSystemRights]  $FileSystemRight,
    [System.Security.AccessControl.InheritanceFlags]  $InheritanceFlag,
    [System.Security.AccessControl.PropagationFlags]  $PropagationFlag,

    [System.String] $ADUserFolderPath,
    [System.String] $Company,
    [System.String] $Domain,
    [System.String] $LogFilePath,
    [System.String] $Password,
    [System.String] $SearchBase,
    [System.String] $Server,
    [System.String] $SiteName,
    [System.String] $Username
)

# Get folder path of currenct script 
$FolderPathOfCurrentScript = Split-Path -Parent $MyInvocation.MyCommand.Path

# Source Variables file path
. ($FolderPathOfCurrentScript + "\Variables.ps1")

if ($AccessControlType -eq $null) {
    $AccessControlType = $DefaultAccessControlType
}

if ($FileSystemRight -eq $null) {
    $FileSystemRight = $DefaultFileSystemRight
}

if ($InheritanceFlag -eq $null) {
    $InheritanceFlag = $DefaultInheritanceFlag
}

if ($PropagationFlag -eq $null) {
    $PropagationFlag = $DefaultPropagationFlag
}

if ($ADUserFolderPath.Length -eq 0) {
    $ADUserFolderPath = $DefaultADUserFolderPath
}

if ($Company.Length -eq 0) {
    $Company = $DefaultCompany
}

if ($Domain.Length -eq 0) {
    $Domain = $DefaultDomain
}

if ($LogFilePath.Length -eq 0) {
    $LogFilePath = $DefaultLogFilePath
}

if ($Password.Length -eq 0) {
    $Password = $DefaultPassword
}

if ($SearchBase.Length -eq 0) {
    $SearchBase = $DefaultSearchBase
}

if ($Server.Length -eq 0) {
    $Server = $DefaultServer
}

if ($SiteName.Length -eq 0) {
    $SiteName = $DefaultSiteName
}

if ($Username.Length -eq 0) {
    $Username = $DefaultUsername
}

# Set current module path
$CurrentModulePath = $FolderPathOfCurrentScript + "\WindowsPowerShell\Modules\"

# Get default $PSModulePath or append $CurrentModulePath to $PSModulePath if $CurrentModulePath doesn't exist
if ([Environment]::GetEnvironmentVariable("PSModulePath").Contains($CurrentModulePath) -eq $false) {
    [Environment]::SetEnvironmentVariable("PSModulePath", ([Environment]::GetEnvironmentVariable("PSModulePath") + ';' + $CurrentModulePath))
}

Import-Module -Force -Name NewFolderForADUser -Verbose
$Usernames = New-FolderForADUser -ADUserFolderPath $ADUserFolderPath -Company $Company -Domain $Domain -LogFilePath $LogFilePath -Password $Password -SearchBase $SearchBase -Server $Server -Username $Username -AccessControlType $AccessControlType -FileSystemRight $FileSystemRight -InheritanceFlag $InheritanceFlag -PropagationFlag $PropagationFlag

Import-Module -Force -Name AddingWebDAVAuthoringRules -Verbose
Add-WebDAVAuthoringRules -Domain $Domain -SiteName $SiteName -Usernames $Usernames
