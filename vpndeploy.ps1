$server_address = "azuregateway-bf9c0077-ac07-4d12-a818-f8b4dadaff59-46609366b518.vpn.azure.com"
$connection_name = "Azure VPN"

$vpnadded = $null
$vpnadded = Get-VpnConnection -name "Azure VPN" -AllUserConnection

If ($vpnadded -ne $null){
    exit
}

Else {
    [xml]$EAPXml = Get-Content -Path C:\eapconfig.xml

    Add-VpnConnection -Name $connection_name -ServerAddress $server_address -TunnelType "Sstp" -EncryptionLevel "Required" -AuthenticationMethod Eap -EapConfigXmlStream $EAPXml -SplitTunneling -Force -RememberCredential -AllUserConnection

    Add-VpnConnectionRoute -ConnectionName $connection_name -DestinationPrefix "192.168.100.0/23"
    Add-VpnConnectionRoute -ConnectionName $connection_name -DestinationPrefix "192.168.50.0/23"
    Add-VpnConnectionRoute -ConnectionName $connection_name -DestinationPrefix "52.239.170.72/32"
}
