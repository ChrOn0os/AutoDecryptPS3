cls
# TEXTS AND ACKNOWLEDGMENTS
$Host.UI.RawUI.WindowTitle = 'Auto-Decrypt PS3 ISOs | made by chr0nos'
Write-Host "Script made by chr0nos `n`nDecryptor made by Redrrx, thanks to him!`nhttps://github.com/Redrrx/ps3dec`n`nThanks to aldostools & redump.org for the decryption keys" -ForegroundColor DarkMagenta

# RETRIEVE JSON DATA
if (!(test-path ".\gamesList.json")){Invoke-WebRequest https://raw.githubusercontent.com/ChrOn0os/AutoDecryptPS3/refs/heads/main/gamesList.json -OutFile "gamesList.json"}
$json = Get-Content -Path ".\gamesList.json" -Raw | ConvertFrom-Json

# CHECK IF "KEYS" FOLDER EXISTS, IF NOT, CREATE IT
if (!(test-path ".\keys\")){[void](md ".\keys\")}

# CHECK IF PS3DEC.EXE EXISTS, IF NOT, DOWNLOAD IT
if (!(test-path ".\ps3dec.exe")){Invoke-WebRequest https://github.com/Redrrx/ps3dec/releases/download/0.2.0/ps3dec.exe -OutFile "ps3dec.exe"}

# SEARCH ISO
$iso_name = Get-ChildItem -Path .\ -Filter *.iso -Recurse -File -Name | ForEach-Object {
    [System.IO.Path]::GetFileNameWithoutExtension($_)
}

# PRINT ISO NAME
Write-Host "`nISO Found : $iso_name"  -ForegroundColor Yellow

# GET BOTH MD5
Write-Host "`nRetrieving MD5 Hashes..." -ForegroundColor Yellow
$md5_json = ($json | Where-Object { $_.name -eq $iso_name}).md5
Write-Host "MD5 JSON : $md5_json" -ForegroundColor DarkGray
$md5_iso = (Get-FileHash ".\$iso_name.iso" -Algorithm MD5).Hash
Write-Host "MD5 ISO : $md5_iso" -ForegroundColor DarkGray

# COMPARE BOTH MD5
if ($md5_iso.ToString() -eq $md5_json.ToString()) 
{
Write-Host "MD5 Hash is valid" -ForegroundColor Green

# EXTRACT DKEY FROM JSON
($json | Where-Object { $_.name -eq $iso_name}).dkey | Out-File -FilePath ".\keys\$iso_name.dkey"

# START DECRYPTOR
Write-Host "`nStarting the decryptor..`n" -ForegroundColor Green
.\ps3dec.exe --iso $iso_name".iso" --auto --skip

# DELETE ENCRYPTED ISO & DKEY
Remove-Item -Path ".\$iso_name.iso"
Remove-Item -Path ".\keys\$iso_name.dkey"

# RENAME DECRYPTED ISO
Rename-Item -Path ".\$iso_name.iso_decrypted.iso" -NewName ".\$iso_name.iso"

Write-Host "`nThanks for using the script!`n"  -ForegroundColor DarkMagenta
}else{Write-Host "MD5 Hash isn't valid`n`nPlease close the program and verify your ISO`n`nISO MD5 : $md5_iso`nJSON MD5 : $md5_json" -ForegroundColor Red}
