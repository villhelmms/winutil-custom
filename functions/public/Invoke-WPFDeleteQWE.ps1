function Invoke-WPFDeleteQWE {
    # Enter existing account username
    $UsernameDelete = "qwe"

    $adsiDelete = [ADSI]"WinNT://$env:COMPUTERNAME"
    $existingDelete = $adsiDelete.Children | Where-Object {$_.SchemaClassName -eq 'user' -and $_.Name -eq $UsernameDelete }

    # Check if the user exists
    if ($null -ne $existingDelete) {
        # If user existss
        # delete old user
        Write-Host "-----> Deleting user "$UsernameDelete"..." -ForegroundColor Yellow
        & NET USER $UsernameDelete /delete | Out-Null
        Write-Host "-----> User "$UsernameDelete" deleted successfully!" -ForegroundColor Green
        Write-Host "----------------------------------------------"
        Write-Host "----- User $UsernameDelete has been deleted -----"
        Write-Host "----------------------------------------------"

    # If user does not exist
    } else {
        Write-Host "-----> User "$UsernameDelete" does not exist!" -ForegroundColor Red
    }
}
