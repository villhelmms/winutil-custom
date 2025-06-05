function Invoke-WPFDeleteCreateUser {
    # Enter existing account username
    $UsernameDelete = "Skolens"
    $UsernameNew = "Skolens"
    $PasswordNew = ""

    $adsiDelete = [ADSI]"WinNT://$env:COMPUTERNAME"
    $existingDelete = $adsiDelete.Children | Where-Object {$_.SchemaClassName -eq 'user' -and $_.Name -eq $UsernameDelete }

    # Check if the user exists
    if ($null -ne $existingDelete) {
        # If user exists
        # delete old user
        Write-Host "-----> Deleting user "$UsernameDelete"..." -ForegroundColor Yellow
        & NET USER $UsernameDelete /delete | Out-Null
        Write-Host "----------------------------------------------"
        Write-Host "----- User $UsernameDelete has been deleted -----"
        Write-Host "----------------------------------------------"

    # If user does not exist
    } else {
        Write-Host "-----> User "$UsernameDelete" does not exist!" -ForegroundColor Red
        Write-Host "-----> New User "$UsernameNew" HAS NOT BEEN CREATED!" -ForegroundColor Red
        Write-Host "-----> Script Stopped!" -ForegroundColor Red
        Break
    }

    $adsi = [ADSI]"WinNT://$env:COMPUTERNAME"
    $existing = $adsi.Children | Where-Object {$_.SchemaClassName -eq 'user' -and $_.Name -eq $UsernameNew }

    # Check if the user exists
    if ($null -eq $existing) {
        # If user does not exist
        # create new user
        Write-Host "-----> Creating user "$UsernameNew"..." -ForegroundColor Yellow
        & NET USER $UsernameNew $PasswordNew /add /y /expires:never | Out-Null
        Write-Host "-----> User "$UsernameNew" created successfully!" -ForegroundColor Green
    } else {
        # Set password if user already exists
        Write-Host "-----> Setting password for existing user "$UsernameNew"..." -ForegroundColor Yellow
        $existing.SetPassword($PasswordNew)
        Write-Host "-----> Password for existing user "$UsernameNew" has been set successfully!" -ForegroundColor Green
    }
    # Set user password to never expire
    Write-Host "-----> Ensuring password for "$UsernameNew" never expires..." -ForegroundColor Yellow
    Set-LocalUser -Name $UsernameNew -PasswordNeverExpires $true
    Write-Host "-----> Password for "$UsernameNew" has been set to never expire!" -ForegroundColor Green
    Write-Host "----------------------------------------------"
    Write-Host "----- New User $UsernameNew has been created -----"
    Write-Host "----------------------------------------------"
}
