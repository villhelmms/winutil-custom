function Invoke-WPFVJCGWallpaper {
    # Define the URL of the wallpaper
    $wallpaperUrl = "https://www.vjcgimnazija.lv/wp-content/uploads/2025/06/vjcg_fons.png"

    # Define the path where the wallpaper will be saved
    $wallpaperPath = "$env:TEMP\vjcg_fons.jpg"

    try {
        # Download the wallpaper from the URL
        Invoke-WebRequest -Uri $wallpaperUrl -OutFile $wallpaperPath -ErrorAction Stop

        # Set the fill/tiling style using the Windows Registry
        $regPath = "HKCU:\Control Panel\Desktop"
        Set-ItemProperty -Path $regPath -Name WallpaperStyle -Value "10" # Fill
        Set-ItemProperty -Path $regPath -Name TileWallpaper -Value "0" # No tiling

        if (-not ([System.Management.Automation.PSTypeName]'WinUtilVJCGWallpaperNative').Type) {
            Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class WinUtilVJCGWallpaperNative {
    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, string pvParam, uint fWinIni);
}
"@
        }

        $SPI_SETDESKWALLPAPER = 0x0014
        $SPIF_UPDATEINIFILE = 0x01
        $SPIF_SENDCHANGE = 0x02

        # Set the path and repaint the desktop in one call
        [WinUtilVJCGWallpaperNative]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $wallpaperPath, ($SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)) | Out-Null

        Write-Host "VJCG wallpaper applied."
    } catch {
        Write-Warning "Failed to set VJCG wallpaper: $_"
        [System.Windows.MessageBox]::Show(
            "Failed to set the VJCG wallpaper: $($_.Exception.Message)",
            "WinUtil",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Warning
        ) | Out-Null
    }
}
