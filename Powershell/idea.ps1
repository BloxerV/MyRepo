# Define the list of computer names
$ComputerNames = @("Computer1", "Computer2", "Computer3") # Replace with your actual list of computer names
$KBFilter = "KB\d+" # Adjust this regex as needed
$Raporty = "C:\Path\To\Reports" # Replace with your actual path for reports
$InfoList = New-Object System.Collections.ArrayList

function Get-RemoteInfo {
    param (
        [string]$ComputerName,
        [string]$KBFilter
    )

    # Get HotFixes
    $HotFixes = Get-HotFix -ComputerName $ComputerName | Where-Object { $_.HotFixID -match $KBFilter } | Select-Object -ExpandProperty HotFixID

    # Get logged on users
    $LoggedOnUsers = (query user /server:$ComputerName 2>$null) -split "`n" | Where-Object {$_ -match '^>'} | ForEach-Object { ($_ -split '\s+')[1] }

    # Get disk space
    $DiskSpace = wmic /node:$ComputerName logicalDisk Where DriveType="3" Get FreeSpace | Select-Object -Skip 1 | Where-Object { $_ -match '\d+' } | ForEach-Object { [long]$_ }

    # Get CCM cache size and KBs
    $CCMCacheSize = (Get-ChildItem -Path "\\$ComputerName\c$\Windows\ccmcache\" -Recurse | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
    $CCMCacheKBs = Get-ChildItem -Path "\\$ComputerName\c$\Windows\ccmcache\" -Force -Recurse -Include Windows1* -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name

    # Get Software Distribution KBs and old folders
    $SoftwareDistributionKBs = Get-ChildItem -Path "\\$ComputerName\c$\Windows\SoftwareDistribution\Download\" -Recurse -Include Windows1* -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name
    $SoftwareDistributionOld = Get-Item "\\$ComputerName\c$\Windows\" -Filter "SoftwareDistribution_*" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name

    # Get OS info
    $OSInfo = wmic /node:$ComputerName os get Version,InstallDate,LastBootUpTime /format:csv | ConvertFrom-Csv

    # Check for Windows.old
    $WindowsOld = Test-Path "\\$ComputerName\c$\Windows.old"

    return @{
        HotFix = $HotFixes -join ' '
        Uzytkownik = $LoggedOnUsers -join ', '
        WolneMiejsceNaDysku = "{0:N2} GB" -f ($DiskSpace / 1GB)
        CacheRozmiar = "{0:N2} GB" -f ($CCMCacheSize / 1GB)
        KBwCCMCache = $CCMCacheKBs -join ' '
        KBwSofterze = $SoftwareDistributionKBs -join ' '
        SoftwareDistributionOld = $SoftwareDistributionOld -join ' '
        OSVersja = $OSInfo.Version
        DataInstalacjiOS = $OSInfo.InstallDate
        DataUruchomieniaPC = $OSInfo.LastBootUpTime
        WinOld = if ($WindowsOld) { 'Windows.old' } else { '' }
    }
}

foreach ($ComputerName in $ComputerNames) {
    Write-Host "Processing $ComputerName..."

    # Copy ReportingEvents.log
    Copy-Item -Path "\\$ComputerName\c$\Windows\SoftwareDistribution\ReportingEvents.log" -Destination "$Raporty\$ComputerName.log" -ErrorAction SilentlyContinue

    # Get remote information
    $Result = Get-RemoteInfo -ComputerName $ComputerName -KBFilter $KBFilter

    # Create custom object with gathered information
    $CSvRaport = [PSCustomObject]@{
        Name = $ComputerName
        HotFix = $Result.HotFix
        Uzytkownik = $Result.Uzytkownik
        WolneMiejsceNaDysku = $Result.WolneMiejsceNaDysku
        CacheRozmiar = $Result.CacheRozmiar
        KBwCCMCache = $Result.KBwCCMCache
        KBwSofterze = $Result.KBwSofterze
        SoftwareDistributionOld = $Result.SoftwareDistributionOld
        OSVersja = $Result.OSVersja
        DataInstalacjiOS = $Result.DataInstalacjiOS
        DataUruchomieniaPC = $Result.DataUruchomieniaPC
        WinOld = $Result.WinOld
    }

    # Add to InfoList
    [void]$InfoList.Add($CSvRaport)
}

# After processing all computers, you can export the results to a CSV file
$InfoList | Export-Csv -Path "$Raporty\SystemInfo_Report.csv" -NoTypeInformation -Encoding UTF8

Write-Host "Processing complete. Report saved to $Raporty\SystemInfo_Report.csv"