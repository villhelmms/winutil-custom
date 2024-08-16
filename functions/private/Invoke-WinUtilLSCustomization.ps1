function Invoke-WinUtilLSCustomization {
  <#
  .SYNOPSIS
      Disables/Enables Lock Screen Customization
  .PARAMETER Enabled
      Indicates whether to enable or disable themes
  #>
  Param($Enabled)
  try {
      if ($Enabled -eq $false) {
          Write-Host "Enabling Lock Screen Customization"
          $value = 0
      }
      else {
          Write-Host "Disabling Lock Screen Customization"
          $value = 1
      }
      $Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
      Set-ItemProperty -Path $Path -Name NoChangingLockScreen -Value $value
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
