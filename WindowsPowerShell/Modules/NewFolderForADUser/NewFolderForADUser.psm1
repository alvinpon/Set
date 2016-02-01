function New-FolderForADUser (
    [System.Security.AccessControl.AccessControlType] $AccessControlType,
    [System.Security.AccessControl.FileSystemRights]  $FileSystemRight,
    [System.Security.AccessControl.InheritanceFlags]  $InheritanceFlag,
    [System.Security.AccessControl.PropagationFlags]  $PropagationFlag,

    [System.String] $ADUserFolderPath,
    [System.String] $Company,
    [System.String] $Domain,
    [System.String] $LogFilePath,
    [System.String] $Password,
    [System.String] $SearchBase,
    [System.String] $Server,
    [System.String] $Username
) {
    # Import ActiveDirectory module
    Import-Module ActiveDirectory

    $SuccessfullyCreatedSamAccountNames = @()
        
    # Catch all exceptions when executing cmdlets and print error message
    try {
        # Set credential for remote server
        $Credential = New-Object -ArgumentList $Username, (ConvertTo-SecureString -String $Password -AsPlainText -Force) -TypeName System.Management.Automation.PSCredential -ErrorAction Stop
        
        # Query ADUsers and extract SamAccountName attribute, if there is no SamAccountName attribute then throws an exception.
        $SamAccountNames = Get-ADUser -Credential $Credential -Filter {(Company -eq $Company) -and (EmployeeID -eq 'G') -and (ObjectClass -eq "user")} -SearchBase $SearchBase -Server $Server | Select-Object -ExpandProperty "SamAccountName"
        if ($SamAccountNames.Length -eq 0) {
            throw [System.Management.Automation.RuntimeException] "No SamAccountNames Found for $Company."
        }
        
        # Create folder for each name if it doesn't exist and record into Log.txt.
        Get-Date | Write-Host
        Get-Date | Out-File -Append -FilePath $LogFilePath
        foreach ($SamAccountName in $SamAccountNames) {
            if ((Test-Path -Path ($ADUserFolderPath + $SamAccountName) -PathType Container) -eq $true) {
                Write-Host ((Get-Date).ToString() + " unsuccessfully created folder, $SamAccountName.")
                ((Get-Date).ToString() + " unsuccessfully created folder, $SamAccountName.") | Out-File -Append -FilePath $LogFilePath
            } else {
                New-Item -ItemType "directory" -Name $SamAccountName -Path $ADUserFolderPath | Out-Null
                $FileSystemAccessRule   = New-Object -ArgumentList "$Domain\$SamAccountName", $FileSystemRight, $InheritanceFlag, $PropagationFlag, $AccessControlType -TypeName System.Security.AccessControl.FileSystemAccessRule
                $ObjectOfACL            = Get-Acl -Path ($ADUserFolderPath + $SamAccountName)
                $ObjectOfACL.AddAccessRule($FileSystemAccessRule)
                Set-Acl -AclObject $ObjectOfACL -Path ($ADUserFolderPath + $SamAccountName)

                Write-Host ((Get-Date).ToString() + " successfully created folder, $SamAccountName.")
                ((Get-Date).ToString() + " successfully created folder, $SamAccountName.") | Out-File -Append -FilePath $LogFilePath
                $SuccessfullyCreatedSamAccountNames += $SamAccountName
            }
        }
        Write-Host ("Unsuccessfully created folders " + ($SamAccountNames.Length - $SuccessfullyCreatedSamAccountNames.Length).ToString() + ", " + "Successfully created folders " + ($SuccessfullyCreatedSamAccountNames.Length).ToString() + '.')
        ("Unsuccessfully created folders " + ($SamAccountNames.Length - $SuccessfullyCreatedSamAccountNames.Length).ToString() + ", " + "Successfully created folders " + ($SuccessfullyCreatedSamAccountNames.Length).ToString() + '.') | Out-File -Append -FilePath $LogFilePath
    } catch [Exception] {
        Write-Host "The type of exception: " $_.Exception.GetType().FullName
        Write-Host "Error message: "         $Error[0]
        "The type of exception: "          + $_.Exception.GetType().FullName | Out-File -Append -FilePath $LogFilePath
        "Error message: "                  + $Error[0]                       | Out-File -Append -FilePath $LogFilePath
    }

    return $SuccessfullyCreatedSamAccountNames
}