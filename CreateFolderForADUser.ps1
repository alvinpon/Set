Import-Module ActiveDirectory

# Get contents from property.txt and set value to credential, searchBase and server variable.
$contents   = Get-Content -Path .\property.txt
$credential = $contents[0]
$searchBase = $contents[1]
$server     = $contents[2]

# Get ADUsers from server and extract name attribute.
$sAMAccountNames = Get-ADUser -Credential $credential -Filter * -ResultSetSize $null -SearchBase $searchBase -Server $server | Select-Object -ExpandProperty "sAMAccountName"

# Create folder for each name if it doesn't exist.
# Reference page: https://technet.microsoft.com/en-us/library/ff730951.aspx
foreach ($sAMAccountName in $sAMAccountNames) {
    if ((Test-Path -Path "C:\Users\ponalvin\Desktop\webaccounts-scripts\$sAMAccountName" -PathType Container) -eq $true) {
        Write-Host "This folder exists."
    } else {
        New-Item -ItemType "directory" -Name $sAMAccountName -Path "C:\Users\ponalvin\Desktop\webaccounts-scripts\"
        $fileSystemAccessRight  = [System.Security.AccessControl.FileSystemRights]"Read"
        $inheritanceFlag        = [System.Security.AccessControl.InheritanceFlags]::None
        $propagationFlag        = [System.Security.AccessControl.PropagationFlags]::None
        $accessControlType      = [System.Security.AccessControl.AccessControlType]::Allow
        $fileSystemAccessRule   = New-Object System.Security.AccessControl.FileSystemAccessRule("SMCNET\ponalvin", $fileSystemAccessRight, $inheritanceFlag, $propagationFlag, $accessControlType)
        $objectOfACL            = Get-Acl -Path "C:\Users\ponalvin\Desktop\webaccounts-scripts\$sAMAccountName"
        $objectOfACL.AddAccessRule($fileSystemAccessRule)
        Set-Acl -Path "C:\Users\ponalvin\Desktop\webaccounts-scripts\$sAMAccountName" -AclObject $objectOfACL
    }
}

# Not workable functions. Please don't uncomment.
<#
function Get-ContentsFromFile($credential, $searchBase, $server) {
    $contents    = Get-Content -Path .\property.txt
    $credential = $contents[0]
    $searchBase = $contents[1]
    $server     = $contents[2]
}

function Get-ADUSersFromRemoteServer($ADUsers, $credential, $searchBase, $server) {
    $ADUsers = Get-ADUser -Credential $credential -Filter * -ResultSetSize $null -SearchBase $searchBase -Server $server | Select-Object -ExpandProperty 'SamAccountName'
}
#>

#Reference script. Please don't uncomment.
<#
#modify display name of all users in AD (based on search criteria) to the format "LastName, FirstName Initials"
ForEach ($ADUser in $ADUsers) 
{

 #The line below creates a folder for each user in the \\server\users$ share
 #Ensure that you have configured the 'Users' base folder as outlined in the post

#New-Item -ItemType Directory -Path "\\70411SRV1\Users$\$($ADUser.sAMAccountname)"
New-Item -ItemType Directory -Path "\\70411SRV1\Users$\$($ADUser.DisplayName)"
#add option to create with GivenName Surname but comment it out

#Grant each user Full Control to the users home folder only

#define domain name to use in the $UsersAm variable

$Domain = '70411Lab'

#Define variables for the access rights

#Define variable for user to grant access (IdentityReference: the user name in Active Directory)
#Usually in the format domainname\username or groupname

$UsersAm = "$Domain\$($ADUser.sAMAccountname)" #presenting the sAMAccountname in this format 
#stops it displaying in Distinguished Name format 

#Define FileSystemAccessRights:identifies what type of access we are defining, whether it is Full Access, Read, Write, Modify

$FileSystemAccessRights = [System.Security.AccessControl.FileSystemRights]"FullControl"

#define InheritanceFlags:defines how the security propagates to child objects by default
#Very important - so that users have ability to create or delete files or folders 
#in their folders

$InheritanceFlags = [System.Security.AccessControl.InheritanceFlags]::"ContainerInherit", "ObjectInherit"

#Define PropagationFlags: specifies which access rights are inherited from the parent folder (users folder).

$PropagationFlags = [System.Security.AccessControl.PropagationFlags]::None

#Define AccessControlType:defines if the rule created below will be an 'allow' or 'Deny' rule

$AccessControl =[System.Security.AccessControl.AccessControlType]::Allow 
#define a new access rule to apply to users folfers

$NewAccessrule = New-Object System.Security.AccessControl.FileSystemAccessRule `
    ($UsersAm, $FileSystemAccessRights, $InheritanceFlags, $PropagationFlags, $AccessControl) 


#set acl for each user folder#First, define the folder for each user

#$userfolder = "\\70411SRV1\Users$\$($ADUser.sAMAccountname)"
$userfolder = "\\70411SRV1\Users$\$($ADUser.DisplayName)"

$currentACL = Get-ACL -path $userfolder
#Add this access rule to the ACL
$currentACL.SetAccessRule($NewAccessrule)
#Write the changes to the user folder
Set-ACL -path $userfolder -AclObject $currentACL

#set variable for homeDirectory (personal folder) and homeDrive (drive letter)

#$homeDirectory = "\\70411SRV1\Users$\$($ADUser.sAMAccountname)" #This maps the folder for each user 
$homeDirectory = "\\70411SRV1\Users$\$($ADUser.DisplayName)" #This maps the folder for each user 

#Set homeDrive for each user

$homeDrive = "H" #This maps the homedirectory to drive letter H 
#Ensure that drive letter H is not in use for any of the users

#Update the HomeDirectory and HomeDrive info for each user

Set-ADUser -server $ADserver -credential $GetAdminact -Identity $ADUser.sAMAccountname -Replace @{HomeDirectory=$homeDirectory}
Set-ADUser -server $ADserver -credential $GetAdminact -Identity $ADUser.sAMAccountname -Replace @{HomeDrive=$homeDrive}

}
#END SCRIPT
#>