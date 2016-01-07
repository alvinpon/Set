<ol>
	<li>Create file</li>
	<ol>
		<li>Create a file named Variables.ps1 in the same location of CreateFolderADUser.ps1</li>
        	<li>Set $username, $password, $searchBase, $server, $domain, $path and $credential variables and assign value</li>
        	<p>
            		$username   = "ldapr@smccd.net"<br>
	            	$password   = "XXXXX" | ConvertTo-SecureString -AsPlainText -Force<br>
        	    	$searchBase = "ou=District,dc=smccd,dc=net"<br>
            		$server     = "XXXX.smccd.net"<br>
	            	$domain     = "smccd.net"<br>
        	    	$path       = "C:\Users\ponalvin\Desktop\webaccounts-scripts\"<br>
           		$credential = New-Object System.Management.Automation.PSCredential $username, $password<br>
	        <p>
	</ol>
</ol>