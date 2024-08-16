function Invoke-WinUtilWallpaper {
  <#
  .SYNOPSIS
      Disables/Enables Wallpaper
  .PARAMETER Enabled
      Indicates whether to enable or disable wallpaper
  #>
  Param($Enabled)
  try {
      if ($Enabled -eq $false) {
          Write-Host "Enabling Wallpaper"
          $value = 0
      }
      else {
          Write-Host "Disabling Wallpaper"
          $value = 1
      }
      $Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop"
      Set-ItemProperty -Path $Path -Name NoAddingComponents -Value $value
      Set-ItemProperty -Path $Path -Name NoChangingWallPaper -Value $value
      Set-ItemProperty -Path $Path -Name NoComponents -Value $value
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
