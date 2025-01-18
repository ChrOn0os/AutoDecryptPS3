# AutoDecryptPS3
**AutoDecryptPS3** is a PowerShell script that fully automates the decryption of ISO files for PlayStation 3 using the [PS3DEC](https://github.com/Redrrx/ps3dec) tool made by **Redrrx**. 
No manual intervention is required: the script handles everything from start to finish!

## Key Features :
- **Automatic download of PS3DEC**: the tool is fetched if it’s not already present.
- **MD5 checksum verification**: ensures the integrity of your file before starting decryption.
- **.dkey file generation**: automatically creates the correct key file for your ISO.
- **Decryption and cleanup**: start the decryption process automatically and deletes the non-decrypted ISO after the process is complete.

## Benefits :
- **Fully automated**: no manual steps needed.
- **Fast and straightforward**: perfect for users looking for an efficient, hassle-free solution.
- **Reliable**: performs checks to guarantee a flawless output.

## Usage :
1. Place your ISO file in the same folder as the script.  
2. Run the PowerShell script:  
   ```powershell
   .\AutoDecryptPS3.ps1

## Contribute :
Contributions are always welcome! If you have ideas for improvements or need to report an issue, feel free to open an issue or submit a pull request.

## Acknowledgements :
- [PS3DEC by Redrrx](https://github.com/Redrrx/ps3dec)
- [Aldostools PS3 DKEY Database](https://ps3.aldostools.org/dkey.html)
- [redump.org](http://redump.org/)
