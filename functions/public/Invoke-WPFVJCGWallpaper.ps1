function Invoke-WPFVJCGWallpaper {
   # Define the URL of the wallpaper
    $wallpaperUrl = "https://www.vjcgimnazija.lv/wp-content/uploads/2025/06/vjcg_fons.png"

    # Define the path where the wallpaper will be saved
    $wallpaperPath = "$env:TEMP\vjcg_fons.jpg"

    # Create a temporary directory item to store the wallpaper
    $tempFile = New-Item -ItemType File -Path $wallpaperPath -Force

    # Download the wallpaper from the URL
    Invoke-WebRequest -Uri $wallpaperUrl -OutFile $tempFile.FullName

    # Set the wallpaper using the Windows Registry
    $regPath = "HKCU:Control Panel\Desktop"
    Set-ItemProperty -Path $regPath -Name Wallpaper -Value $tempFile.FullName
    Set-ItemProperty -Path $regPath -Name WallpaperStyle -Value "10" # Fill
    Set-ItemProperty -Path $regPath -Name TileWallpaper -Value "0" # No tiling

    # Notify Windows to update the wallpaper
    rundll32.exe user32.dll, UpdatePerUserSystemParameters
}
