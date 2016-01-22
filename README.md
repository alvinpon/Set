
# 1. Execute InstallingScript
> * For example: C:\Users\ponalvin\Desktop\webaccounts-scripts\InstallingModule.ps1
# 2. Rename File 
> * Rename VariablesSample.ps1 to Variables.ps1
# 3. Assign Value
> * $Username              = "Username"
> * $Password              = "Password" | ConvertTo-SecureString -AsPlainText -Force
> * $DefaultCompany        = "DefaultCompany"
> * $SearchBase            = "ou=ou,dc=dc,dc=dc"
> * $Server                = "Server"
> * $Domain                = "Domain"
> * $ADUserFolderPath      = "PathOfADUserFolder"
> * $LogFilePath           = "PathOfLogFile"
> * $FileSystemAccessRight = [System.Security.AccessControl.FileSystemRights]::FullControl
> * $InheritanceFlag       = [System.Security.AccessControl.InheritanceFlags]::None
> * $PropagationFlag       = [System.Security.AccessControl.PropagationFlags]::None
> * $AccessControlType     = [System.Security.AccessControl.AccessControlType]::Allow
# 4. Excute Function
> ## Not Use Parameter
>> * New-FolderForADUser
> ## Use Parameter
>> * New-FolderForADUser -Company "CSM"