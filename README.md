
Creating file
	1. Creating a file named Variables.ps1 in the same location of CreateFolderADUser.ps1
	2. Set $username, $password, $searchBase, $server, $domain, $path and $credential variables and assign value
Example
	$username   = "ldapr@smccd.net"
	$password   = "XXXXX" | ConvertTo-SecureString -AsPlainText -Force
	$searchBase = "ou=District,dc=smccd,dc=net"
	$server     = "XXXX.smccd.net"
	$domain     = "smccd.net"
	$path       = "C:\Users\ponalvin\Desktop\webaccounts-scripts\"
	$credential = New-Object System.Management.Automation.PSCredential $username, $password