# Import the list of computer names from a text file
$computerList = Get-Content -Path "C:\temp\computers.txt"

# Define the function as a script block
$functionScriptBlock = {
    function Get-ComputerHotFixes {
        param (
            [string]$ComputerName
        )

        # Check if the computer is online
        if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
            # Retrieve installed hotfixes
            try {
                $hotFixes = Get-HotFix -ComputerName $ComputerName
                [pscustomobject]@{
                    ComputerName = $ComputerName
                    Status       = 'Online'
                    HotFixes     = $hotFixes
                }
            } catch {
                [pscustomobject]@{
                    ComputerName = $ComputerName
                    Status       = 'Online - Error retrieving hotfixes'
                    HotFixes     = $null
                }
            }
        } else {
            [pscustomobject]@{
                ComputerName = $ComputerName
                Status       = 'Offline'
                HotFixes     = $null
            }
        }
    }
}

# Initialize an array to store job information
$jobs = @()

# Start a job for each computer to perform the check asynchronously
foreach ($computer in $computerList) {
    $jobs += Start-Job -InitializationScript $functionScriptBlock -ScriptBlock {
        param ($computerName)
        Get-ComputerHotFixes -ComputerName $computerName
    } -ArgumentList $computer
}

# Wait for all jobs to complete
$jobs | ForEach-Object { $_ | Wait-Job }

# Retrieve and collect the results
$results = $jobs | ForEach-Object { Receive-Job -Job $_ }

# Prepare data for CSV export
$csvData = @()
foreach ($result in $results) {
    if ($result.HotFixes) {
        foreach ($hotfix in $result.HotFixes) {
            $csvData += [pscustomobject]@{
                ComputerName = $result.ComputerName
                Status       = $result.Status
                HotFixID     = $hotfix.HotFixID
                InstalledOn  = $hotfix.InstalledOn
                Description  = $hotfix.Description
            }
        }
    } else {
        $csvData += [pscustomobject]@{
            ComputerName = $result.ComputerName
        }
    }
}

$csvData | Export-Csv -Path "C:\temp\output.csv"