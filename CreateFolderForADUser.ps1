# Import ActiveDirectory module
Import-Module ActiveDirectory

# Load common variables into this script
. .\Variables.ps1

# Allow user to choose a company to overwrite default value of $company
$userInput = Read-Host "Enter the Company (Cañada, CSM or Skyline)"
if ($userInput.Length -ne 0 -and ($userInput.Equals("Cañada") -or $userInput.Equals("CSM") -or $userInput.Equals("Skyline"))) {
    $company = $userInput
}

# Set credential for remote server
$credential = New-Object -ArgumentList $username, $password -TypeName System.Management.Automation.PSCredential

# Get ADUsers from server and extract SamAccountName attribute.
$samAccountNames = Get-ADUser -Credential $credential -Filter {(Company -eq $company) -and (EmployeeID -eq 'G') -and (ObjectClass -eq "user")} -ResultSetSize $null -SearchBase $searchBase -Server $server | Select-Object -ExpandProperty "SamAccountName"

# Create folder for each name if it doesn't exist.
foreach ($samAccountName in $samAccountNames) {
    if ((Test-Path -Path ($path + $samAccountName) -PathType Container) -eq $true) {
        Write-Host "This folder exists."
    } else {
        New-Item -ItemType "directory" -Name $samAccountName -Path $path
        $fileSystemAccessRule   = New-Object System.Security.AccessControl.FileSystemAccessRule("$domain\$samAccountName", $fileSystemAccessRight, $inheritanceFlag, $propagationFlag, $accessControlType)
        $objectOfACL            = Get-Acl -Path ($path + $samAccountName)
        $objectOfACL.AddAccessRule($fileSystemAccessRule)
        Set-Acl -Path ($path + $samAccountName) -AclObject $objectOfACL
    }
}