function Create-FolderForADUser ([String] $Company) {
    # Import ActiveDirectory module
    Import-Module ActiveDirectory

    # Load common variables into this script
    . .\Variables.ps1

    # Allow user to choose a company to overwrite $DefaultCompany
    if ($Company.Length -ne 0 -and ($Company.Equals("Cañada") -or $Company.Equals("CSM") -or $Company.Equals("Skyline"))) {
        $DefaultCompany = $Company
    }

    
    # Catch all exceptions when executing cmdlets and print error message
    try {
        # Set credential for remote server
        $Credential = New-Object -ArgumentList $Username, $Password -TypeName System.Management.Automation.PSCredential -ErrorAction Stop

        # Get ADUsers from server and extract SamAccountName attribute.
        $SamAccountNames = Get-ADUser -Credential $Credential -Filter {(Company -eq $DefaultCompany) -and (EmployeeID -eq 'G') -and (ObjectClass -eq "user")} -ResultSetSize $null -SearchBase $SearchBase -Server $Server | Select-Object -ExpandProperty "SamAccountName"
            
        # Create folder for each name if it doesn't exist and record into Log.txt.
        Get-Date | Out-File ($Path + "Log.txt") -Append
        foreach ($SamAccountName in $SamAccountNames) {
            if ((Test-Path -Path ($Path + $SamAccountName) -PathType Container) -eq $true) {
                $SamAccountName + " folder has existed." | Out-File -FilePath ($Path + "Log.txt") -Append
            } else {
                New-Item -ItemType "directory" -Name $SamAccountName -Path $Path
                $FileSystemAccessRule   = New-Object System.Security.AccessControl.FileSystemAccessRule("$Domain\$SamAccountName", $FileSystemRight, $InheritanceFlag, $PropagationFlag, $AccessControlType)
                $ObjectOfACL            = Get-Acl -Path ($Path + $SamAccountName)
                $ObjectOfACL.AddAccessRule($FileSystemAccessRule)
                Set-Acl -Path ($Path + $SamAccountName) -AclObject $ObjectOfACL
                $SamAccountName + " folder has created. File system access right is" + $FileSystemAccessRight | Out-File -FilePath ($Path + "Log.txt") -Append
            }
        }
    } catch [Exception] {
        Write-Host "The type of exception: " $_.Exception.GetType().FullName
        Write-Host "Error message: "         $Error[0]
    }
}