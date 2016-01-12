
# Rename file
>	1. Rename Variables-sample.ps1 to Variables.ps1
# Assign Value
>	* $username              = "xxxx"
>	* $password              = "xxxx" | ConvertTo-SecureString -AsPlainText -Force
>	* $company               = "xxxx" 
>	* $searchBase            = "ou=xxxx,dc=xxxx,dc=xxxx"
>	* $server                = "xxxx"
>	* $domain                = "xxxx"
>	* $path                  = "xxxx"
>	* $fileSystemAccessRight = [System.Security.AccessControl.FileSystemRights]::FullControl
>	* $inheritanceFlag       = [System.Security.AccessControl.InheritanceFlags]::None
>	* $propagationFlag       = [System.Security.AccessControl.PropagationFlags]::None
>	* $accessControlType     = [System.Security.AccessControl.AccessControlType]::Allow