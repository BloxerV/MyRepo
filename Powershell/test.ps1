







$RegexListaKBLicznik = $RegexListaKB.Count
$RegexOldKB = ($RegexListaKB[0..($RegexListaKBLicznik 3)]) -join '|'
$ListaStatusowPc = @()
$ListaPrzeskanowanychkb = @()

$PsObjCsv0ldKb = [System.Collections.Generic.List[PSObject]]::new()
$ListaPcOnline = [System.Collections.Generic.List[string]]() 
$ListaStatusowkb = [System.Collections.Generic.List[string]]()

del SwynikKb

del $FolderSkanukb\*.txt

del $Raporty.log\*.log -Force

    ForEach($PC in $PcList) {

        $ListaStatusowPc[$PC] [System.Net.NetworkInformation.Ping]::new().SendPingAsync($PC)

    }

Write-Host "Pingownaie stacji" -Nollewline

    while($false -in $ListaStatusowPc.Values.IsCompleted) {

        sleep -Milliseconds 300; Write-Host. -Noliewline
    }


    foreach($PC in $PcList) {


        $Status = $ListaStatusowPc[$PC].Result


        if($Status.Status -eq 'Success') {

            $ListaPcOnline.Add($PC)
        }
    }

$ListaPcOnlineCount = ($ListaPcOnline).count

    ForEach($CN in $ListaPcOnline) {
        Start-Process powershell.exe -windowstyle hidden -ArgumentList "(Get-Hotfix -Description 'Securit Update' -CN $CN).HotfixId >> $FolderSkanukB\$CN.txt
    }


$CountSkanuowkb (Get-ChildItem-Path $FolderSkanukb -File -Recurse | Measure-Object).Count

While (-not ($CountSkanuowkb -ge $ListaPcOnlineCount)) {

    Write-Host "Nadal czekam na wyniki"

    Start-Sleep -Seconds 10

    $CountSkanuowkb (Get-ChildItem -Path $FolderSkanukb File -Recurse | Measure-Object).Count

}

Start-Sleep: -Seconds 50

$PrzeskanowaneStacje = (get-item-Path $FolderSkanukb\*.txt).BaseName

Write-Host "Tworzenie listy Hotfixow dia przeskanowanych stacji"

    foreach($Cli in $PrzeskanowaneStacje) {

    Get-Content $FolderSkanukb\$CN.txt | Where-Object {$match $RegexKB) | ForEach-Object ($Lista