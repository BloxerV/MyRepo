elseif($script_number -eq 6) {
    Clear-Host

    Remove-Item $ScanKB -Force
    Remove-Item $Raporty\BHW*.log -Force
    Remove-Item $WynikiCSVKB -Force

    Return-OnlineStations

    ForEach($CN in $online) {
        Write-Host "Sprawdzam $CN"

        Copy-Item -Path "\\$CN\c$\Windows\SoftwareDistribution\ReportingEvents.log" -Destination $Raporty\$CN.log -ErrorAction SilentlyContinue

        $disk = wmic /node:$CN logicalDisk Where DriveType="3" Get DeviceID,FreeSpace | Select-String -Pattern "[0-9]"
        $disk -match "\d+" | Out-Null

        $systeminfo = systeminfo.exe /S $CN /FO CSV | ConvertFrom-Csv

        $CSvRaport = [pscustomobject]@{
            Name = $CN
            HotFix = ((Get-HotFix -CN $CN).HotFixID -split (',') | Select-String -Pattern $KBFilter) -join ' '
            Uzytkownik = ((query user /server:$CN) -split "\n" -replace '\s\s+', ';' | ConvertFrom-Csv -Delimiter ';').Username
            WolneMiejsceNaDysku = "{0:N2} GB" -f ([int64]$Matches[0] / 1GB)
            CacheRozmiar = "{0:N2} GB" -f ((Get-ChildItem -Path \\$CN\c$\Windows\ccmcache\ -Recurse | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum / 1GB)
            KBwCCMCache = (Get-ChildItem -Path "\\$CN\c$\Windows\ccmcache\" -Force -Recurse -Include Windows1* -ErrorAction SilentlyContinue | ForEach-Object { $_.Name }) -join ' '
            KBwSofterze = (Get-ChildItem -Path "\\$CN\c$\Windows\SoftwareDistribution\Download\" -Recurse -Include Windows1* -ErrorAction SilentlyContinue | ForEach-Object { $_.Name }) -join ' '
            SoftwareDistributionOld = (Get-Item "\\$CN\c$\Windows\" -Filter "SoftwareDistribution_*" -ErrorAction SilentlyContinue | ForEach-Object { $_.Name }) -join ' '
            OSVersja = $systeminfo.'OS Version'
            DataInstalacjiOS = $systeminfo.'Original Install Date'
            DataUruchomieniaPC = $systeminfo.'System Boot Time'
            WinOld = (Get-Item "\\$CN\c$\" -Filter "Windows.old" -ErrorAction SilentlyContinue | ForEach-Object { $_.Name }) -join ' '
        }

        $InfoList.Add($CSvRaport)
    }

    $PrzeskanowaneStacje = (Get-Item -Path $Raporty\*.log).BaseName

    foreach($CN in $PrzeskanowaneStacje) {
        Get-Content $Raporty\$CN.log | Where-Object { $_ -match $regex } | ForEach-Object { $ListaPrzeskanowanychKB[$CN] = $_ }
    }

    $ListaPrzeskanowanychKB.GetEnumerator() | Select-Object Name, Value | Export-Csv -NoTypeInformation -Encoding UTF8 -Delimiter ';' $WynikiError

    $InfoList.ToArray() | Export-Csv -NoTypeInformation -Encoding UTF8 -Delimiter ';' -Path $WynikiCSVKB
}