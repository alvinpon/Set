
# Create Folder
> 1. Create WindowsPowerShell folder in Documents folder
> 2. Create Modules folder in WindwosPowershell folder
> 3. Create CreatingFolderFoADUser folder in Moudles folder
# Move File
> * Move CreatingFolderForADUser.psm1 and VariablesSample.ps1 to CreatingFolderFoADUser folder
# Rename File 
> * Rename VariablesSample.ps1 to Variables.ps1
# Assign Value
> * $Username              = "Username"
> * $Password              = "Password" | ConvertTo-SecureString -AsPlainText -Force
> * $DefaultCompany        = "DefaultCompany"
> * $SearchBase            = "ou=ou,dc=dc,dc=dc"
> * $Server                = "Server"
> * $Domain                = "Domain"
> * $PathOfADUserFolder    = "PathOfADUserFolder"
> * $PathOfLogFile         = "PathOfLogFile"
> * $FileSystemAccessRight = [System.Security.AccessControl.FileSystemRights]::FullControl
> * $InheritanceFlag       = [System.Security.AccessControl.InheritanceFlags]::None
> * $PropagationFlag       = [System.Security.AccessControl.PropagationFlags]::None
> * $AccessControlType     = [System.Security.AccessControl.AccessControlType]::Allow
# Excute Function
> ## Import Module
>> * Import-Module -Name "CreatingFolderForADUser" -Verbose
> ## Use Parameter
>> * New-FolderForADUser -Company "CSM"