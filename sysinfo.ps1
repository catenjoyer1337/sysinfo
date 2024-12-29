$os = Get-CimInstance -ClassName Win32_OperatingSystem
$cpu = Get-CimInstance -ClassName Win32_Processor
$gpu = Get-CimInstance -ClassName Win32_VideoController
$ram = Get-CimInstance -ClassName Win32_PhysicalMemory
$totalRam = ($ram | Measure-Object -Property Capacity -Sum).Sum / 1GB

$pcName = $env:COMPUTERNAME

$hdd = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID = 'C:'"
$hddUsedSpace = [math]::Round($hdd.FreeSpace / 1GB, 2)
$hddTotalSpace = [math]::Round($hdd.Size / 1GB, 2)
$hddFreeSpace = $hddTotalSpace - $hddUsedSpace
$hddUsedPercentage = [math]::Round(($hddUsedSpace / $hddTotalSpace) * 100, 2)


Write-Host "Hello " -NoNewline; Write-Host $pcName -NoNewline
Write-Host ", your OS is " -NoNewline; Write-Host $os.Caption
Write-Host "------------------------------------------------"
Write-Host "Your CPU: " -NoNewline; Write-Host $cpu.Name
Write-Host "Your GPU: " -NoNewline; Write-Host $gpu.Name
Write-Host "Your RAM: " -NoNewline; Write-Host $totalRam -NoNewline; Write-Host "GB"
Write-Host "------------------------------------------------"
Write-Host "Your MAIN HDD/SSD is at " -NoNewline; Write-Host $hddUsedSpace "GB/" -NoNewline; Write-Host $hddTotalSpace -NoNewline; Write-Host "GB"
Write-Host "You still have " -NoNewline; Write-Host $hddFreeSpace "GB or " -NoNewline; Write-Host $hddUsedPercentage "% free"

