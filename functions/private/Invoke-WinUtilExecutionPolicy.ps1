function Invoke-WinUtilExecutionPolicy {

    Param($Enabled)
    try {
        if ($Enabled -eq $false) {
            Write-Host "Execution Policy set to Unrestricted"
            Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force
        } else {
            Write-Host "Execution Policy set to Restricted"
            Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Restricted -Force
        }
    } catch [System.Security.SecurityException] {
        Write-Warning "Unable to set execution policy due to a Security Exception"
    } catch {
        Write-Warning "Unable to set execution policy due to unhandled exception"
        Write-Warning $psitem.Exception.StackTrace
    }
}
