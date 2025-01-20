cls
$local_ver = "1.1.0"
$latest_ver = (Invoke-WebRequest https://raw.githubusercontent.com/ChrOn0os/AutoDecryptPS3/refs/heads/main/version.txt).Content
# TEXTS AND ACKNOWLEDGMENTS
$Host.UI.RawUI.WindowTitle = 'Auto-Decrypt PS3 ISOs | made by chr0nos'
Write-Host "Script made by chr0nos `n`nDecryptor made by Redrrx, thanks to him!`nhttps://github.com/Redrrx/ps3dec`n`nThanks to aldostools & redump.org for the decryption keys" -ForegroundColor DarkMagenta
Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor White

# CHECK IF SCRIPT IS UP TO DATE
if ([version]$local_ver -ge [version]$latest_ver) {Write-Host "`nScript is up to date !"  -ForegroundColor Green}
else {
Write-Host "`nPlease update the script !`nLocal version : $local_ver`nLatest version : $latest_ver`nhttps://github.com/ChrOn0os/AutoDecryptPS3"  -ForegroundColor Red
Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor White}

# RETRIEVE JSON DATA
if (!(test-path ".\gamesList.json")) {Invoke-WebRequest https://raw.githubusercontent.com/ChrOn0os/AutoDecryptPS3/refs/heads/main/gamesList.json -OutFile "gamesList.json"}
$json = Get-Content -Path ".\gamesList.json" -Raw | ConvertFrom-Json

# CHECK IF PS3DEC.EXE EXISTS, IF NOT, DOWNLOAD IT
if (!(test-path ".\ps3dec.exe")){Invoke-WebRequest https://github.com/Redrrx/ps3dec/releases/download/0.2.0/ps3dec.exe -OutFile "ps3dec.exe"}

# CHECK IF ZIP FILE EXIST & IF YES, EXTRACT IT
if (Test-Path ".\*.zip" -PathType leaf) 
{
	# INSTALL 7Zip4Powershell IF NOT FOUND
	if (!(Get-Command "Expand-7Zip" -errorAction SilentlyContinue))
	{Install-Module -Name "7Zip4Powershell" -Scope CurrentUser -Force}
	
	# SEARCH ZIP, EXTRACT IT & DELETE THE ZIP AFTERWARDS
	$zip_name = Get-ChildItem -Path .\ -Filter *.zip -Recurse -File -Name | ForEach-Object {[System.IO.Path]::GetFileNameWithoutExtension($_)}
	if ($zip_name -eq ($json | Where-Object {$_.name -eq $zip_name}).name){
		[void](Expand-7Zip -ArchiveFileName "$zip_name.zip" -TargetPath ".\")
		Remove-Item -Path ".\$zip_name.zip"}
		else {
		Write-Host "`n.zip archive doesn't correspond to any ISO!`n`nPlease close the program and verify the name of your archive`n(name needs to be in redump format)"  -ForegroundColor Red 
		exit}
}

# SEARCH ISO
$iso_name = Get-ChildItem -Path .\ -Filter *.iso -Recurse -File -Name | ForEach-Object {[System.IO.Path]::GetFileNameWithoutExtension($_)}

# PRINT ISO NAME
Write-Host "`nISO Found : $iso_name"  -ForegroundColor Yellow

# GET BOTH MD5
Write-Host "`nRetrieving MD5 Hashes..." -ForegroundColor Yellow
$md5_json = ($json | Where-Object {$_.name -eq $iso_name}).md5
Write-Host "MD5 JSON : $md5_json" -ForegroundColor DarkGray
$md5_iso = (Get-FileHash ".\$iso_name.iso" -Algorithm MD5).Hash
Write-Host "MD5 ISO  : $md5_iso" -ForegroundColor DarkGray

# COMPARE BOTH MD5
if ($md5_iso.ToString() -eq $md5_json.ToString()) {
Write-Host "MD5 Hash is valid" -ForegroundColor Green

# EXTRACT DKEY FROM JSON
$dkey = ($json | Where-Object {$_.name -eq $iso_name}).dkey

# START DECRYPTOR
Write-Host "`nStarting the decryptor..`n" -ForegroundColor Green
.\ps3dec.exe --iso "$iso_name.iso" --dk "$dkey" --skip

# DELETE ENCRYPTED ISO & RENAME DECRYPTED ISO
Remove-Item -Path ".\$iso_name.iso"
Rename-Item -Path ".\$iso_name.iso_decrypted.iso" -NewName ".\$iso_name.iso"
Write-Host "`nThanks for using the script!"  -ForegroundColor DarkMagenta
Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor White
}else {
Write-Host "`nMD5 Hash isn't valid`n`nPlease close the program and verify your ISO" -ForegroundColor Red
Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor White}
