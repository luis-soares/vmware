# Luis Antonio Soares da Silva (lui_eu@msn.com / luissoares@outlook.com)
# To use this script, you must install PowerCLI.

$vms = @()
$vms = Get-VM
foreach ($vmname in $vms.name){
    $VM = Get-VM -name $VMname
    $vGPUDevice = $VM.ExtensionData.Config.hardware.Device | Where {$_.backing.vgpu}
    $gpu = $vGPUDevice | Select @{Name="Summary";Expression={$_.DeviceInfo.Summary}}
    write-host $vmname, $gpu |ft
}
