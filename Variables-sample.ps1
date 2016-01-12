$username              = "username"
$password              = "password" | ConvertTo-SecureString -AsPlainText -Force
$company               = "company"
$searchBase            = "ou=ou,dc=dc,dc=dc"
$server                = "server"
$domain                = "domain"
$path                  = "path"
$fileSystemAccessRight = [System.Security.AccessControl.FileSystemRights]::FullControl
$inheritanceFlag       = [System.Security.AccessControl.InheritanceFlags]::None
$propagationFlag       = [System.Security.AccessControl.PropagationFlags]::None
$accessControlType     = [System.Security.AccessControl.AccessControlType]::Allow