Import-Module ActiveDirectory

$SchoolName = 'Cañada' # 'CSM', 'Cañada', 'Skyline'
$ADUsers = Get-ADUser -SearchBase "OU=$SchoolName,OU=District,DC=smccd,DC=net" -Filter * | Select-Object -ExpandProperty Name

foreach ($ADUser in $ADUsers) {
    New-Item -Path "C:\Users\ponalvin\Desktop\Active Directory\$ADUser" -ItemType directory
}

$HomeFolders = Get-ChildItem .\ -Directory
foreach ($HomeFolder in $HomeFolders) {
    $Path = $HomeFolder.FullName
    $Username = $HomeFolder.Name
    $Acl = Get-Acl -Path $Path
    $Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("SMCNET\ponalvin", "FullControl", "ContainerInherit", "None", "Allow")
    $Acl.SetAccessRule($Ar)
    Set-Acl $Path -AclObject $Acl
}