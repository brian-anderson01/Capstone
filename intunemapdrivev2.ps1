# Script was found here, I just replaced the sample script with my own from Azure:
# https://yvez.be/2020/11/04/map-azure-file-share-using-intune-powershell-script/

$user = whoami

$ScriptDirectory = $env:APPDATA + "\Intune"
# Check if directory already exists.
if (!(Get-Item -Path $ScriptDirectory)) {
    New-Item -Path $env:APPDATA -Name "Intune" -ItemType "directory"
}

# Logfile
$ScriptLogFilePath = $ScriptDirectory + "\ConnectAzureFileShare.log"

Add-Content -Path $ScriptLogFilePath -Value ((Get-Date).ToString() + ": " + "Running script as " + $user)

$connectTestResult = Test-NetConnection -ComputerName azfss.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    New-PSDrive -Name K -PSProvider FileSystem -Root "\\azfss.file.core.windows.net\share1" -Persist -Scope Global
}

If (Get-PSDrive -Name K) {
    Add-Content -Path $ScriptLogFilePath -Value ((Get-Date).ToString() + ": " + "K-Drive mapped successfully.")
}

Else {
    Add-Content -Path $ScriptLogFilePath -Value ((Get-Date).ToString() + ": " + "Please verify installation.")
}
pause
