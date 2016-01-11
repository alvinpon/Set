$username   = "username"
$password   = "password" | ConvertTo-SecureString -AsPlainText -Force
$searchBase = "ou=ou,dc=dc,dc=dc"
$server     = "server"
$domain     = "domain"
$path       = "path"
$credential = New-Object -ArgumentList $username, $password -TypeName System.Management.Automation.PSCredential