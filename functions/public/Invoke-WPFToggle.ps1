function Invoke-WPFToggle {

    <#

    .SYNOPSIS
        Invokes the scriptblock for the given toggle

    .PARAMETER Button
        The name of the toggle to invoke

    #>

    Param ([string]$Button)

    # Use this to get the name of the button
    #[System.Windows.MessageBox]::Show("$Button","Chris Titus Tech's Windows Utility","OK","Info")

    Switch -Wildcard ($Button) {

        "WPFToggleDarkMode" {Invoke-WinUtilDarkMode -DarkMoveEnabled $(Get-WinUtilToggleStatus WPFToggleDarkMode)}
        "WPFToggleBingSearch" {Invoke-WinUtilBingSearch $(Get-WinUtilToggleStatus WPFToggleBingSearch)}
        "WPFToggleNumLock" {Invoke-WinUtilNumLock $(Get-WinUtilToggleStatus WPFToggleNumLock)}
        "WPFToggleVerboseLogon" {Invoke-WinUtilVerboseLogon $(Get-WinUtilToggleStatus WPFToggleVerboseLogon)}
        "WPFToggleShowExt" {Invoke-WinUtilShowExt $(Get-WinUtilToggleStatus WPFToggleShowExt)}
        "WPFToggleSnapWindow" {Invoke-WinUtilSnapWindow $(Get-WinUtilToggleStatus WPFToggleSnapWindow)}
        "WPFToggleSnapFlyout" {Invoke-WinUtilSnapFlyout $(Get-WinUtilToggleStatus WPFToggleSnapFlyout)}
        "WPFToggleSnapSuggestion" {Invoke-WinUtilSnapSuggestion $(Get-WinUtilToggleStatus WPFToggleSnapSuggestion)}
        "WPFToggleMouseAcceleration" {Invoke-WinUtilMouseAcceleration $(Get-WinUtilToggleStatus WPFToggleMouseAcceleration)}
        "WPFToggleStickyKeys" {Invoke-WinUtilStickyKeys $(Get-WinUtilToggleStatus WPFToggleStickyKeys)}
        "WPFToggleTaskbarWidgets" {Invoke-WinUtilTaskbarWidgets $(Get-WinUtilToggleStatus WPFToggleTaskbarWidgets)}
        "WPFToggleTaskbarSearch" {Invoke-WinUtilTaskbarSearch $(Get-WinUtilToggleStatus WPFToggleTaskbarSearch)}
        "WPFToggleTaskView" {Invoke-WinUtilTaskView $(Get-WinUtilToggleStatus WPFToggleTaskView)}
        "WPFToggleHiddenFiles" {Invoke-WinUtilHiddenFiles $(Get-WinUtilToggleStatus WPFToggleHiddenFiles)}
        "WPFToggleTaskbarAlignment" {Invoke-WinUtilTaskbarAlignment $(Get-WinUtilToggleStatus WPFToggleTaskbarAlignment)}
        "WPFToggleDetailedBSoD" {Invoke-WinUtilDetailedBSoD $(Get-WinUtilToggleStatus WPFToggleDetailedBSoD)}
        "WPFToggleExecutionPolicy" {Invoke-WinUtilExecutionPolicy $(Get-WinUtilToggleStatus WPFToggleExecutionPolicy)}
        "WPFToggleWallpaper" {Invoke-WinUtilWallpaper $(Get-WinUtilToggleStatus WPFToggleWallpaper)}
        "WPFToggleThemes" {Invoke-WinUtilToggleThemes $(Get-WinUtilToggleStatus WPFToggleThemes)}
        "WPFToggleLSCustomization" {Invoke-WinUtilLSCustomization $(Get-WinUtilToggleStatus WPFToggleLSCustomization)}
        "WPFToggleColorCustomization" {Invoke-WinUtilColorCustomization $(Get-WinUtilToggleStatus WPFToggleColorCustomization)}
        "WPFToggleSetThisPC" {Invoke-WinUtilSetThisPC $(Get-WinUtilToggleStatus WPFToggleSetThisPC)}
    }
}
