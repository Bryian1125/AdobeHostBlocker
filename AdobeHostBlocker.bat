@echo off

set "url=https://a.dove.isdumb.one/list.txt"
set "tempfile=%TEMP%\webdata.txt"
set "localfile=C:\Windows\System32\drivers\etc\hosts"

echo --------------------------------------------------------------------------------------
echo Comparing hostfiles with a.dove.isdumb.one. Please wait as this may take a few moments
echo --------------------------------------------------------------------------------------

curl -s %url% > "%tempfile%"

taskkill /IM "CoreSync.exe" /F
taskkill /IM "Adobe Crash Processor.exe" /F
taskkill /IM "Adobe Desktop Service.exe" /F
taskkill /IM "CoreSync.exe" /F
taskkill /IM "Creative Cloud Helper.exe" /F
taskkill /IM "AdobeIPCBroker.exe" /F
taskkill /IM "AdobeNotificationClient.exe" /F


for /f "usebackq delims=" %%a in ("%tempfile%") do (
    findstr /x /c:"%%a" "%localfile%" >nul
    if errorlevel 1 (
	echo Blocking host %%a
        echo %%a>>"%localfile%"
    )
)

del "%tempfile%"

echo -----------------------------------------------
echo Editing complete. You may now exit the program.
echo -----------------------------------------------

pause