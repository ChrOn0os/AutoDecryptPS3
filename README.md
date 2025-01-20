# 🔓 AutoDecryptPS3
**AutoDecryptPS3** is a PowerShell script that fully automates the decryption of ISO files for PlayStation 3 using the [PS3DEC](https://github.com/Redrrx/ps3dec) tool made by **Redrrx**.
No manual intervention is required: the script handles everything from start to finish!

## ✨ Key Features :
- **Automatic download of PS3DEC**: the tool is fetched if it’s not already present.
- **.zip archive support**: install a decompression tool (7Zip4Powershell) if needed, extracts archive and deletes the .zip file once the extraction is complete.
- **MD5 checksum verification**: ensures the integrity of your file before starting decryption.
- **Automatic DKEY retrieval**: automatically fetch the correct key for your ISO.
- **Decryption and cleanup**: start the decryption process automatically and deletes the non-decrypted ISO after the process is complete.
- **Version check system**: The script verify his current version compared to the latest one available and notify users if an update is available.

## 🌟 Benefits :
- **Fully automated**: no manual steps needed except running the script.
- **Fast and straightforward**: perfect for users looking for an efficient, hassle-free solution.
- **Reliable**: performs checks to guarantee a flawless output.

## 🛠️ Usage :
1. Place your ISO file / .zip archive (from Redump group only) in the same folder as the script.
   - You can download Redump's encrypted PS3 disc images from one of these links:
   - [Myrient](https://myrient.erista.me/files/Redump/Sony%20-%20PlayStation%203/)
   - [Archive.org](https://archive.org/details/@cvlt_of_mirrors?query=%22Sony+Playstation+3%22+%22Redump.org%22&sort=title)

2. Run the PowerShell script:
   ```powershell
   .\AutoDecryptPS3.ps1

## 🤝 Contribute :
Contributions are always welcome! If you have ideas for improvements or need to report an issue, feel free to open an issue or submit a pull request.

## 🙏 Acknowledgements :
- [PS3DEC by Redrrx](https://github.com/Redrrx/ps3dec)
- [Aldostools PS3 DKEY Database](https://ps3.aldostools.org/dkey.html)
- [redump.org](http://redump.org/)
