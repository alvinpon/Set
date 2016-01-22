function New-FolderForADUser ([String] $Company) {
    # Import ActiveDirectory module
    Import-Module ActiveDirectory

    # Assign Variables file path
    $VariablesFilePath = $PSCommandPath
    for ($i = 0 ;$i -le 3; $i++) {
        $VariablesFilePath = Split-Path -Parent $VariablesFilePath
    }
    $VariablesFilePath = $VariablesFilePath + "\Variables.ps1"

    # If Variable.ps1 file exist, execute the statements below
    if ((Test-Path -Path $VariablesFilePath -PathType Leaf) -eq $true) {
        . $VariablesFilePath

        # If $Company length is zero or $Company is an empty string, assigning $DefaultCompany value to $Company
        if ($Company.Length -eq 0 -or $Company.Equals("")) {
            $Company = $DefaultCompany
        }
        
        # Catch all exceptions when executing cmdlets and print error message
        try {
            # Set credential for remote server
            $Credential = New-Object -ArgumentList $Username, $Password -TypeName System.Management.Automation.PSCredential -ErrorAction Stop

            # Query ADUsers and extract SamAccountName attribute, if there is no SamAccountName attribute then throws an exception.
            $SamAccountNames = Get-ADUser -Credential $Credential -Filter {(Company -eq $Company) -and (EmployeeID -eq 'G') -and (ObjectClass -eq "user")} -ResultSetSize $null -SearchBase $SearchBase -Server $Server | Select-Object -ExpandProperty "SamAccountName"
            if ($SamAccountNames.Length -eq 0) {
                throw [System.Management.Automation.RuntimeException] "No SamAccountNames Found for $Company."
            }
            
            # Create folder for each name if it doesn't exist and record into Log.txt.
            Get-Date | Out-File -Append -FilePath $LogFilePath
            foreach ($SamAccountName in $SamAccountNames) {
                if ((Test-Path -Path ($ADUserFolderPath + $SamAccountName) -PathType Container) -eq $true) {
                    $SamAccountName + " folder has existed." | Out-File -Append -FilePath $LogFilePath
                } else {
                    New-Item -ItemType "directory" -Name $SamAccountName -Path $ADUserFolderPath
                    $FileSystemAccessRule   = New-Object System.Security.AccessControl.FileSystemAccessRule("$Domain\$SamAccountName", $FileSystemRight, $InheritanceFlag, $PropagationFlag, $AccessControlType)
                    $ObjectOfACL            = Get-Acl -Path ($ADUserFolderPath + $SamAccountName)
                    $ObjectOfACL.AddAccessRule($FileSystemAccessRule)
                    Set-Acl -AclObject $ObjectOfACL -Path ($ADUserFolderPath + $SamAccountName)
                    "$SamAccountName folder has created. File system right is $FileSystemRight" | Out-File -Append -FilePath $LogFilePath
                }
            }
        } catch [Exception] {
            Write-Host "The type of exception: " $_.Exception.GetType().FullName
            Write-Host "Error message: "         $Error[0]
        }
    } else {
        Write-Host "Sorry, There is no Variables.ps1."
    }
}