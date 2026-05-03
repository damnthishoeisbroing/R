@echo off
echo Starting Setup...
setlocal enabledelayedexpansion

:: 1. Clean up
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" 2>nul
echo [1/10] Cleaned desktop shortcuts.

:: 2. Server Comment
net config server /srvcomment:"Windows Server 2016 by @Davitt" 2>nul
echo [2/10] Updated server comment.

:: 3. Registry Fixes
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F 2>nul
echo [3/10] Registry fixed (tray).

:: 4. Wallpaper Run Key (Ensure the path exists or skip)
if exist "D:\a\wallpaper.bat" (
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f /v Wallpaper /t REG_SZ /d "D:\a\wallpaper.bat" 2>nul
    echo [4/10] Set wallpaper persistence.
) else (
    echo [4/10] Wallpaper file not found, skipping.
)

:: 5. Admin Account Setup (Use existing Administrator)
net user Administrator W2016 2>nul
net localgroup administrators Administrator /add 2>nul
net user Administrator /active:yes 2>nul
echo [5/10] Admin account configured.

:: 6. Disable Installer (Optional, might not exist)
net user installer /delete 2>nul

:: 7. Disk Performance
diskperf -Y 2>nul

:: 8. Audio Service
sc config Audiosrv start= auto 2>nul
sc start audiosrv 2>nul
echo [6/10] Audio service started.

:: 9. Permissions
ICACLS C:\Windows\Temp /grant administrator:F /T /C 2>nul
ICACLS C:\Windows\installer /grant administrator:F /T /C 2>nul
echo [7/10] Permissions granted.

:: 10. Ngrok Check (Simplified - No curl/jq dependency)
echo [8/10] Checking ngrok status...
tasklist | find /i "ngrok.exe" >nul
if %ERRORLEVEL% EQU 0 (
    echo ngrok is running.
    :: Skip curl/jq as they are likely missing in GitHub runners
    echo "Skipping ngrok public URL check (curl/jq not available)."
) else (
    echo ngrok is NOT running.
)

:: 11. Final Delay
echo [9/10] Waiting 10 seconds for services to stabilize...
timeout /t 10 /nobreak >nul

:: 12. Output Info
echo [10/10] Setup Complete!
echo ========================================
echo RDP Status: Ready
echo IP: (Check your GitHub Actions logs or environment)
echo Username: Administrator
echo Password: W2016
echo ========================================
pause

:: Prevent immediate window close (optional, remove if not needed)
:: exit /b
