@echo off
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" >> out.txt 2>&1
net config server /srvcomment:"Windows Server 2016 by @Davitt" >> out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F >> out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f /v Wallpaper /t REG_SZ /d D:\a\wallpaper.bat >> out.txt 2>&1
net user Administrator W2016 >>nul 2>&1
net localgroup administrators Administrator /add >>nul 2>&1
net user Administrator /active:yes >>nul 2>&1
net user installer /delete >>nul 2>&1
diskperf -Y >>nul 2>&1
sc config Audiosrv start= auto >>nul 2>&1
sc start audiosrv >>nul 2>&1
ICACLS C:\Windows\Temp /grant administrator:F >>nul 2>&1
ICACLS C:\Windows\installer /grant administrator:F >>nul 2>&1
echo Successfully Installed, If the RDP is Dead, Please Rebuild Again!
echo IP:
tasklist | find /i "ngrok.exe" >Nul && curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url || echo "Cannot get a troop tunnel, make sure ngrok_auth_token is correct in Settings> Secrets> Repository Secret.Maybe your previous VM is still running: https://dashboard.ngrok.com/status/tunnels"
echo Username: Administrator
echo Password: W2016
echo Please log in to your RDP!
ping -n 10 127.0.0.1 >nul
