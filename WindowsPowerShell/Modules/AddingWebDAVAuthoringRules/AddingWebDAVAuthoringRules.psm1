function Add-WebDAVAuthoringRules (
    [System.String] $Domain,
    [System.String] $SiteName,

    [System.String[]] $UserNames
) {
    [Reflection.Assembly]::LoadWithPartialName("Microsoft.Web.Administration")

    foreach ($UserName in $UserNames) {
        $ServerManager            = New-Object -TypeName microsoft.web.administration.servermanager
        $Config                   = $ServerManager.GetApplicationHostConfiguration()
        $AuthoringRulesSection    = $Config.GetSection("system.webServer/webdav/authoringRules", "$SiteName/$Username")
        $AuthoringRulesCollection = $AuthoringRulesSection.GetCollection()
        $AddElement               = $AuthoringRulesCollection.CreateElement("add")

        $AddElement.setAttributeValue("users", "$Domain\$Username")
        $AddElement.setAttributeValue("path", "*")
        $AddElement.setAttributeValue("access", "Read,Write,Source")
        $AuthoringRulesCollection.Add($AddElement)
        $ServerManager.commitChanges()
    }
}