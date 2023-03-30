using namespace System

$xmlsettings = New-Object System.Xml.XmlWriterSettings
$xmlsettings.Indent = $true
$xmlsettings.IndentChars = "    "

$versionNumber = '5.2.11'

# function AddRepositoryUrl($path) {
#     $propertyGroup = Select-Xml -Path $path -XPath '/Project/PropertyGroup[1]'
#     if ($propertyGroup) {
#         $doc = $propertyGroup.Node.OwnerDocument

#         $urlNode = $doc.CreateNode("element", "RepositoryUrl", $null)
#         $urlNode.InnerText = 'https://github.com/novorender/novorender-backend'
#         $propertyGroup.node.AppendChild($urlNode)

#         $version = $doc.CreateNode("element", "Version", $null)
#         $version.InnerText = $versionNumber
#         $propertyGroup.node.AppendChild($version)

#         # Set the File Name Create The Document
#         $XmlWriter = [System.XML.XmlWriter]::Create($path, $xmlsettings)
#         $doc.Save($XmlWriter)
#         $XmlWriter.Dispose()
#     }
# }

# Get-ChildItem -Path .\ -Filter *.csproj -Recurse -File | ForEach-Object {
#     ((Get-Content -path xbim.essentials.nuspec -Raw) -replace '5.2.9', $versionNumber) | Set-Content -Path xbim.essentials.nuspec
#     AddRepositoryUrl($_.FullName)
# }
# $file = get-item -path 'nuget.config'
# $configuration = Select-Xml -Path $file -XPath '/configuration'
# $packageSources = $configuration.Node['packageSources']
# $packageSources.InnerXml = '<add key="github" value="https://nuget.pkg.github.com/novorender/index.json" />'
# $doc = $configuration.Node.OwnerDocument
# $packageSourceCredentials = $doc.CreateNode("element", "packageSourceCredentials", $null)
# $packageSourceCredentials.InnerXml = '<github><add key="Username" value="SigveBergslien" /><add key="ClearTextPassword" value="key" /></github>'
# $configuration.Node.AppendChild($packageSourceCredentials)
# #$writer = New-Object System.XMl.XmlTextWriter 'tmpfile.xml', $null
# #$writer.Formatting = “indented”
# #$writer.Indentation = 2

# ## Set The Formatting
# #$xmlsettings = New-Object System.Xml.XmlWriterSettings
# #$xmlsettings.Indent = $true
# #$xmlsettings.IndentChars = "    "
# ## Set the File Name Create The Document
# #$writer = [System.XML.XmlWriter]::Create('tmp2file', $xmlsettings)
# $doc.Save($file.FullName)

# ((Get-Content -path xbim.essentials.nuspec -Raw) -replace '5.2.9', $versionNumber) | Set-Content -Path .\xbim.essentials.nuspec
nuget pack .\xbim.essentials.nuspec

dotnet pack --configuration Release
Get-ChildItem -Path .\ -Filter *$versionNumber.nupkg -Recurse -File | ForEach-Object {
    dotnet nuget push $_.FullName --source "github" -k key
}



# $packetSources.Node.RemoveAll()
# $doc = $packetSources.Node.OwnerDocument
# $clearNode = $doc.CreateNode("element", "clear", $null)
# $packetSources.Node.AppendChild($clearNode)
# $githubUrl = $doc.CreateNode("element", "add", $null)
# $attr = $doc.CreateAttribute("key")
# $attr.Value = "github"


# $githubUrl.Attributes.Append("key", "github")
# $githubUrl.Attributes.Append("value", "https://nuget.pkg.github.com/NovoTechAS/index.json")
#$packetSources.Node.AppendChild($githubUrl)
