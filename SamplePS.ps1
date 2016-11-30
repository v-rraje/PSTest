Param
(
    [String[]]
    $RemoteComputers=@('172.17.195.9'),
    [String]
    $UserName,
    [String]
    $PassWord
)
function BackUpBits($cmp)
{
    echo "Running On"$cmp -Verbose
    New-Item D:\RemotePowerShellTest -type directory
}

$PassWordEnc = convertto-securestring $PassWord -asplaintext -force
$MyCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $UserName,$PassWordEnc

foreach($cmp in $RemoteComputers) 
{
    Set-Item WSMan:\localhost\Client\TrustedHosts * -Force
    Invoke-Command -ComputerName $cmp -Port 5985 -Authentication Negotiate -ScriptBlock ${function:BackUpBits} -ArgumentList $cmp -Credential $MyCred -ErrorAction Continue
}
