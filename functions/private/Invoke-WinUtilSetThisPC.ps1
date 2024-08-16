function Invoke-WinUtilSetThisPC {
  Param($Enabled)
  try {
    if ($Enabled -eq $false) {
      Write-Host "Windows Explorer set to This PC"
      $value = 1
  }
  else {
      Write-Host "Windows Explorer set to Home"
      $value = 0
  }
  $Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
  Set-ItemProperty -Path $Path -Name "LaunchTo" -Value $value
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
