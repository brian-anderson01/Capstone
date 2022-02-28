Function start-vpn{

add-type -AssemblyName System.Windows.Forms
[void] [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
& "$env:C:\Users\brian\AppData\Roaming\Microsoft\Network\Connections\Cm\bf9c0077-ac07-4d12-a818-f8b4dadaff59\bf9c0077-ac07-4d12-a818-f8b4dadaff59.pbk"
$a = Get-Process | Where-Object {$_.Name -eq "bf9c0077-ac07-4d12-a818-f8b4dadaff59"}
sleep -m 250
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
sleep 3
check-connection
}


Function check-connection{
$interfaces = ipconfig /all

If ($interfaces -match $filename) {
    Write-Output "VPN connected"
    Exit
}
else {
    Write-Output "VPN not connected"
    start-vpn
}

}


Function check-installed{

$filename = $null;
$filename = Get-ChildItem -Path C:\Users\brian\AppData\Roaming\Microsoft\Network\Connections\Cm -Filter *.pbk -Recurse -File -Name| ForEach-Object {
    [System.IO.Path]::GetFileNameWithoutExtension($_)
}
Write-Output($filename)
If ($filename -ne $null) {
check-connection
}

else {
Exit
}
}

check-installed