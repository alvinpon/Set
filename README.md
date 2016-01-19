
# Rename file
> * Rename Variables-sample.ps1 to Variables.ps1
# Assign Value
> * $Username              = "Username"
> * $Password              = "Password" | ConvertTo-SecureString -AsPlainText -Force
> * $Company               = "Company"
> * $SearchBase            = "ou=ou,dc=dc,dc=dc"
> * $Server                = "Server"
> * $Domain                = "Domain"
> * $Path                  = "Path"
> * $FileSystemAccessRight = [System.Security.AccessControl.FileSystemRights]::FullControl
> * $InheritanceFlag       = [System.Security.AccessControl.InheritanceFlags]::None
> * $PropagationFlag       = [System.Security.AccessControl.PropagationFlags]::None
> * $AccessControlType     = [System.Security.AccessControl.AccessControlType]::Allow
# Excute Function
> ## Source Script
>> * . .\CreateFolderForADUser.ps1
> ## Use Parameter
>> * Create-FolderForADUser -Company "CSM"