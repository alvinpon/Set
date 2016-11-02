# Set

## Rename File
- Rename VariablesSample.ps1 to Variables.ps1

## Assign Value
$DefaultAccessControlType = [System.Security.AccessControl.AccessControlType]::Allow

$DefaultFileSystemRight   = [System.Security.AccessControl.FileSystemRights]::FullControl

$DefaultInheritanceFlag   = [System.Security.AccessControl.InheritanceFlags]::None

$DefaultPropagationFlag   = [System.Security.AccessControl.PropagationFlags]::None

$DefaultADUserFolderPath  = "ADUser folder path"

$DefaultCompany           = "company"

$DefaultDomain            = "domain"

$DefaultLogFilePath       = "log file path"

$DefaultPassword          = "password"

$DefaultSearchBase        = "ou=ou,dc=dc,dc=dc"

$DefaultServer            = "server"

$DefaultSiteName          = "Default Web Site"

$DefaultUsername          = "username"

## Excute Function
- With Parameter
	- ./Run.ps1 -Company "CSM"
- Without Parameter
	- ./Run.ps1
