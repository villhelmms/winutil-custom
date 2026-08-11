function Invoke-WPFDeleteMythware {
    $mythwareProcessNames = @("GATESRV", "LoopbackHelper", "MasterHelper", "ProcHelper64", "DispcapHelper", "StudentMain")
    $mythwarePath = "C:\Program Files (x86)\Mythware"

    $mythwareProcesses = Get-Process | Where-Object { ($_.Path -like "*Mythware*") -or ($mythwareProcessNames -contains $_.Name) }

    if ($mythwareProcesses) {
        foreach ($process in $mythwareProcesses) {
            try {
                Write-Host "-----> Stopping process "$process.Name"..." -ForegroundColor Yellow
                Stop-Process -Id $process.Id -Force -ErrorAction Stop
                Write-Host "-----> Process "$process.Name" stopped successfully!" -ForegroundColor Green
            } catch {
                Write-Host "-----> Failed to stop process "$process.Name": $_" -ForegroundColor Red
            }
        }
    } else {
        Write-Host "-----> No Mythware processes found." -ForegroundColor Yellow
    }

    if (Test-Path $mythwarePath) {
        try {
            Write-Host "-----> Deleting "$mythwarePath"..." -ForegroundColor Yellow
            Remove-Item $mythwarePath -Recurse -Force -ErrorAction Stop
            Write-Host "-----> "$mythwarePath" deleted successfully!" -ForegroundColor Green
        } catch {
            Write-Host "-----> Failed to delete "$mythwarePath": $_" -ForegroundColor Red
        }
    } else {
        Write-Host "-----> "$mythwarePath" does not exist." -ForegroundColor Yellow
    }
    Write-Host "----------------------------------------------"
    Write-Host "----- Mythware removal complete -----"
    Write-Host "----------------------------------------------"
}