
# 1. Rename File 
> * Rename VariablesSample.ps1 to Variables.ps1
# 2. Assign Value
> * $DefaultUsername          = "username"
> * $DefaultPassword          = "password"
> * $DefaultCompany           = "company"
> * $DefaultSearchBase        = "ou=ou,dc=dc,dc=dc"
> * $DefaultServer            = "server"
> * $DefaultDomain            = "domain"
> * $DefaultADUserFolderPath  = "ADUser folder path"
> * $DefaultLogFilePath       = "log file path"
> * $DefaultFileSystemRight   = [System.Security.AccessControl.FileSystemRights]::FullControl
> * $DefaultInheritanceFlag   = [System.Security.AccessControl.InheritanceFlags]::None
> * $DefaultPropagationFlag   = [System.Security.AccessControl.PropagationFlags]::None
> * $DefaultAccessControlType = [System.Security.AccessControl.AccessControlType]::Allow
# 3. Excute Function
> ## Without Parameter
>> * ./Run.ps1
> ## Company Parameter
>> * ./Run.ps1 -Company "CSM"