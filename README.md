<ol>
	<li>Rename File</li>
	<ul>
		<li>Rename VariablesSample.ps1 to Variables.ps1</li>
	</ul>
	<li>Assign Value</li>
	<ul>
		<li>$DefaultAccessControlType = [System.Security.AccessControl.AccessControlType]::Allow</li>
		<li>$DefaultFileSystemRight   = [System.Security.AccessControl.FileSystemRights]::FullControl</li>
		<li>$DefaultInheritanceFlag   = [System.Security.AccessControl.InheritanceFlags]::None</li>
		<li>$DefaultPropagationFlag   = [System.Security.AccessControl.PropagationFlags]::None</li>
		<br>
		<li>$DefaultADUserFolderPath  = "ADUser folder path"</li>
		<li>$DefaultCompany           = "company"</li>
		<li>$DefaultDomain            = "domain"</li>
		<li>$DefaultLogFilePath       = "log file path"</li>
		<li>$DefaultPassword          = "password"</li>
		<li>$DefaultSearchBase        = "ou=ou,dc=dc,dc=dc"</li>
		<li>$DefaultServer            = "server"</li>
		<li>$DefaultSiteName          = "Default Web Site"</li>
		<li>$DefaultUsername          = "username"</li>
	</ul>
	<li>Excute Function</li>
	Without Parameter
	<ul>
		<li>./Run.ps1</li>
	</ul>
	Without Parameter
	<ul>
		<li>./Run.ps1 -Company "CSM"</li>
	</ul>
</ol>
