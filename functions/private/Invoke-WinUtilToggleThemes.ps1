function Invoke-WinUtilToggleThemes {
  <#
  .SYNOPSIS
      Disables/Enables Themes
  .PARAMETER Enabled
      Indicates whether to enable or disable themes
  #>
  Param($Enabled)
  try {
      if ($Enabled -eq $false) {
          Write-Host "Enabling Themes"
          $value = 0
      }
      else {
          Write-Host "Disabling Themes"
          $value = 1
      }
      $Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
      Set-ItemProperty -Path $Path -Name NoThemesTab -Value $value
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
