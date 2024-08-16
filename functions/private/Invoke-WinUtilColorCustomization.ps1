function Invoke-WinUtilColorCustomization {
    <#
    .SYNOPSIS
        Disables/Enables Color Customization
    .PARAMETER Enabled
        Indicates whether to enable or disable color customization
    #>
    Param($Enabled)
    try {
        if ($Enabled -eq $false) {
            Write-Host "Enabling Color Customization"
            $value = 0
        }
        else {
            Write-Host "Disabling Color Customization"
            $value = 1
        }
        $Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
        Set-ItemProperty -Path $Path -Name NoDispAppearancePage -Value $value
    }
    Catch [System.Security.SecurityException] {
        Write-Warning "Unable to set $Path\$Name to $Value due to a Security Exception"
    }
    Catch [System.Management.Automation.ItemNotFoundException] {
        Write-Warning $psitem.Exception.ErrorRecord
    }
    catch {
        Write-Warning "Unable to set $Name due to unhandled exception"
        Write-Warning $psitem.Exception.StackTrace
    }
  }
