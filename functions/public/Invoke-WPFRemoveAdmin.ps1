function Invoke-WPFRemoveAdmin {
<#     # Specify the username and group
    $Username = "Skolens"
    $Group = "Administrators"

    # Check if the user exists
    $user = [ADSI]"WinNT://$env:COMPUTERNAME/$Username,user"
    if ($user.Path -eq $null) {
        Write-Host "User $Username does not exist." -ForegroundColor Red
        exit
    }

    # Check if the user is a member of the Administrators group
    $group = [ADSI]"WinNT://$env:COMPUTERNAME/$Group,group"
    $members = $group.Members() | ForEach-Object { $_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null) }

    if ($members -contains $Username) {
        # Remove the user from the Administrators group
        Write-Host "Removing user $Username from $Group group..." -ForegroundColor Yellow
        & NET LOCALGROUP $Group $Username /delete | Out-Null
        Write-Host "User $Username has been removed from $Group group!" -ForegroundColor Green
    } else {
        Write-Host "User $Username is not a member of the $Group group." -ForegroundColor Yellow
    } #>

    $UsernameNew = "Skolens"
    $GroupAdmin = "Administrators"

    $adsi = [ADSI]"WinNT://$env:COMPUTERNAME"
    $existing = $adsi.Children | Where-Object {$_.SchemaClassName -eq 'user' -and $_.Name -eq $UsernameNew }

    # Check if the user exists
    if ($null -eq $existing) {
        # If user does not exist
        # create new user
        Write-Host "-----> User "$UsernameNew" does not exist!" -ForegroundColor Yellow
    } else {
        # Set password if user already exists
        Write-Host "-----> Removing Group "$GroupAdmin" From "$UsernameNew"..." -ForegroundColor Yellow
        & NET LOCALGROUP $GroupAdmin $UsernameNew /delete | Out-Null
        Write-Host "-----> Group "$GroupAdmin" Has Been Removed From "$UsernameNew"" -ForegroundColor Green
    }
    # Set user password to never expire
    Write-Host "-----> Ensuring password for "$UsernameNew" never expires..." -ForegroundColor Yellow
    Set-LocalUser -Name $UsernameNew -PasswordNeverExpires $true
    Write-Host "-----> Password for "$UsernameNew" has been set to never expire!" -ForegroundColor Green
    Write-Host "----------------------------------------------"
    Write-Host "----- New User $UsernameNew has been updated -----"
    Write-Host "----------------------------------------------"
    Write-Host "----------------------------------------------" -ForegroundColor Red
    Write-Host "----- PLEASE RESTART PC AND CHECK IF USER HAS ADMIN PRIVILAGES -----" -ForegroundColor Red
    Write-Host "----------------------------------------------" -ForegroundColor Red
}
