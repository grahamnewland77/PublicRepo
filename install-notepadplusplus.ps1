$installerPath = "C:\Temp\npp.8.1.9.3.Installer.x64.exe"
Invoke-WebRequest -Uri "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.1.9.3/npp.8.1.9.3.Installer.x64.exe" -OutFile $installerPath
Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait
Remove-Item -Path $installerPath
