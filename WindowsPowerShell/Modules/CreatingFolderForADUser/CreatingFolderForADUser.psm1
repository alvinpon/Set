function New-FolderForADUser (
    [System.Security.AccessControl.AccessControlType] $AccessControlType,
    [System.Security.AccessControl.FileSystemRights]  $FileSystemRight,
    [System.Security.AccessControl.InheritanceFlags]  $InheritanceFlag,
    [System.Security.AccessControl.PropagationFlags]  $PropagationFlag,

    [system.security.securestring] $Password,

    [System.String] $ADUserFolderPath,
    [System.String] $Company,
    [System.String] $Domain,
    [System.String] $LogFilePath,
    [System.String] $SearchBase,
    [System.String] $Server,
    [System.String] $Username
) {
    # Import ActiveDirectory module
    Import-Module ActiveDirectory

    $UnsuccessfullyCreatedCount = 0
    $SuccessfullyCreatedCount   = 0
        
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
        Get-Date | Tee-Object -Append -FilePath $LogFilePath
        foreach ($SamAccountName in $SamAccountNames) {
            if ((Test-Path -Path ($ADUserFolderPath + $SamAccountName) -PathType Container) -eq $true) {
                ((Get-Date).ToString() + " unsuccessfully created folder, $SamAccountName.") | Tee-Object -Append -FilePath $LogFilePath
                $UnSuccessfullyCreatedCount++
            } else {
                New-Item -ItemType "directory" -Name $SamAccountName -Path $ADUserFolderPath | Out-Null
                $FileSystemAccessRule   = New-Object System.Security.AccessControl.FileSystemAccessRule("$Domain\$SamAccountName", $FileSystemRight, $InheritanceFlag, $PropagationFlag, $AccessControlType)
                $ObjectOfACL            = Get-Acl -Path ($ADUserFolderPath + $SamAccountName)
                $ObjectOfACL.AddAccessRule($FileSystemAccessRule)
                Set-Acl -AclObject $ObjectOfACL -Path ($ADUserFolderPath + $SamAccountName)
                ((Get-Date).ToString() + " successfully created folder, $SamAccountName.") | Tee-Object -Append -FilePath $LogFilePath
                $SuccessfullyCreatedCount++
            }
        }
        "Unsuccessfully created folders " + $UnSuccessfullyCreatedCount.ToString() + ", " + "Successfully created folders " + $SuccessfullyCreatedCount.ToString() + " ." | Tee-Object -Append -FilePath $LogFilePath
    } catch [Exception] {
        "The type of exception: " + $_.Exception.GetType().FullName | Tee-Object -Append -FilePath $LogFilePath
        "Error message: " + $Error[0] | Tee-Object -Append -FilePath $LogFilePath
    }
}