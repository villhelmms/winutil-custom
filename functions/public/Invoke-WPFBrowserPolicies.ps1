Function Invoke-WPFBrowserPolicies {
  <#
  .SYNOPSIS
      Enables or disables browser policies for Chrome and Microsoft Edge

  .PARAMETER State
      Indicates whether to enable or disable the browser policies

  #>
  param($State)

    try {
        Write-Host "-----> Google Chrome: Testing path..." -ForegroundColor Yellow
        # Chrome policies
        $chromePath = "HKLM:\SOFTWARE\Policies\Google\Chrome"
        if (!(Test-Path $chromePath)) {
            Write-Host "-----> Google Chrome: New path created" -ForegroundColor Green
            New-Item -Path $chromePath -Force
        } else {
            Write-Host "-----> Google Chrome: path already exists" -ForegroundColor Green
        }

        $chromeProperties = @{
            #"BrowserGuestModeEnforced" = $null
            "NTPCustomBackgroundEnabled" = $null
            "BrowserThemeColor" = $null
            "BrowserSignin" = $null
            "PasswordManagerEnabled" = $null
            "PasswordSharingEnabled" = $null
            "BrowserAddPersonEnabled" = $null
            "SyncDisabled" = $null
            "DefaultBrowserSettingEnabled" = $null
            "PaymentMethodQueryEnabled" = $null
            "AutofillAddressEnabled" = $null
            "ForceGoogleSafeSearch" = $null
            "PrintingEnabled" = $null
            "AutofillCreditCardEnabled" = $null
        }

        if ($State -eq "Enable") {
            $chromeValues = @{
                #"BrowserGuestModeEnforced" = 1
                "NTPCustomBackgroundEnabled" = 0
                "BrowserThemeColor" = "#060606"
                "BrowserSignin" = 0
                "PasswordManagerEnabled" = 0
                "PasswordSharingEnabled" = 0
                "BrowserAddPersonEnabled" = 0
                "SyncDisabled" = 1
                "DefaultBrowserSettingEnabled" = 0
                "PaymentMethodQueryEnabled" = 0
                "AutofillAddressEnabled" = 0
                "ForceGoogleSafeSearch" = 1
                "PrintingEnabled" = 1
                "AutofillCreditCardEnabled" = 0
            }
        } elseif ($State -eq "Disable") {
            $chromeValues = @{
                #"BrowserGuestModeEnforced" = $null
                "NTPCustomBackgroundEnabled" = $null
                "BrowserThemeColor" = $null
                "BrowserSignin" = $null
                "PasswordManagerEnabled" = $null
                "PasswordSharingEnabled" = $null
                "BrowserAddPersonEnabled" = $null
                "SyncDisabled" = $null
                "DefaultBrowserSettingEnabled" = $null
                "PaymentMethodQueryEnabled" = $null
                "AutofillAddressEnabled" = $null
                "ForceGoogleSafeSearch" = $null
                "PrintingEnabled" = $null
                "AutofillCreditCardEnabled" = $null
            }
        }

        Write-Host "-----> Google Chrome: setting properties..." -ForegroundColor Yellow
        foreach ($property in $chromeProperties.GetEnumerator()) {
            if ($chromeValues.ContainsKey($property.Name)) {
                $value = $chromeValues[$property.Name]
                if ($null -eq $value) {
                    Remove-ItemProperty -Path $chromePath -Name $property.Name -ErrorAction SilentlyContinue
                } else {
                    New-ItemProperty -Path $chromePath -Name $property.Name -Value $value -PropertyType $(if ($value -is [string]) { "String" } else { "Dword" }) -Force | Out-Null
                }
            }
        }
        if ($null -eq $value) {
            Write-Host "-----> Google Chrome: properties deleted" -ForegroundColor Green
        } else {
            Write-Host "-----> Google Chrome: properties created" -ForegroundColor Green
        }

        # Microsoft Edge policiess
        $edgePaths = @(
            "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
            "HKLM:\SOFTWARE\Policies\Microsoft\EdgeUpdate"
        )
        Write-Host "-----> Edge: Testing path..." -ForegroundColor Yellow

        foreach ($pathEdge in $edgePaths) {
            if (-not (Test-Path $pathEdge)) {
                New-Item -Path $pathEdge -Force
                Write-Host "-----> Edge: New path created" -ForegroundColor Green
            }
        }

        $edgeProperties = @{
            "NewTabPageContentEnabled" = $null
            "NewTabPageQuickLinksEnabled" = $null
            "SpotlightExperiencesAndRecommendationsEnabled" = $null
            "NewTabPageAllowedBackgroundTypes" = $null
            "ShowCastIconInToolbar" = $null
            "EnableMediaRouter" = $null
            "GamerModeEnabled" = $null
            "PasswordManagerEnabled" = $null
            "AutofillAddressEnabled" = $null
            "BrowserSignin" = $null
            "CryptoWalletEnabled" = $null
            "EdgeCollectionsEnabled" = $null
            "EdgeEDropEnabled" = $null
            "EdgeFollowEnabled" = $null
            "EdgeShoppingAssistantEnabled" = $null
            "EdgeWalletCheckoutEnabled" = $null
            "EdgeWalletEtreeEnabled" = $null
            "HubsSidebarEnabled" = $null
            "ShowMicrosoftRewards" = $null
            "SyncDisabled" = $null
            "NewTabPageBingChatEnabled" = $null
            "WalletDonationEnabled" = $null
            "BrowserAddProfileEnabled" = $null
            "EdgeDefaultProfileEnabled" = $null
            "MSAWebSiteSSOUsingThisProfileAllowed" = $null
            "AIGenThemesEnabled" = $null
            "PinBrowserEssentialsToolbarButton" = $null
            "SplitScreenEnabled" = $null
            "AutofillCreditCardEnabled" = $null
            "ImportPaymentInfo" = $null
            "PrintingEnabled" = $null
            "HideFirstRunExperience" = $null
            "DefaultBrowserSettingEnabled" = $null
            "CreateDesktopShortcutDefault" = $null
            "PersonalizationReportingEnabled" = $null
            "ShowRecommendationsEnabled" = $null
            "ConfigureDoNotTrack" = $null
            "DiagnosticData" = $null
            "EdgeAssetDeliveryServiceEnabled" = $null
        }

        if ($State -eq "Enable") {
            $edgeValues = @{
                "NewTabPageContentEnabled" = 0
                "NewTabPageQuickLinksEnabled" = 0
                "SpotlightExperiencesAndRecommendationsEnabled" = 0
                "NewTabPageAllowedBackgroundTypes" = 3
                "ShowCastIconInToolbar" = 0
                "EnableMediaRouter" = 0
                "GamerModeEnabled" = 0
                "PasswordManagerEnabled" = 0
                "AutofillAddressEnabled" = 0
                "BrowserSignin" = 0
                "CryptoWalletEnabled" = 0
                "EdgeCollectionsEnabled" = 0
                "EdgeEDropEnabled" = 0
                "EdgeFollowEnabled" = 0
                "EdgeShoppingAssistantEnabled" = 0
                "EdgeWalletCheckoutEnabled" = 0
                "EdgeWalletEtreeEnabled" = 0
                "HubsSidebarEnabled" = 0
                "ShowMicrosoftRewards" = 0
                "SyncDisabled" = 1
                "NewTabPageBingChatEnabled" = 0
                "WalletDonationEnabled" = 0
                "BrowserAddProfileEnabled" = 0
                "EdgeDefaultProfileEnabled" = "Skolens"
                "MSAWebSiteSSOUsingThisProfileAllowed" = 0
                "AIGenThemesEnabled" = 0
                "PinBrowserEssentialsToolbarButton" = 0
                "SplitScreenEnabled" = 0
                "AutofillCreditCardEnabled" = 0
                "ImportPaymentInfo" = 0
                "PrintingEnabled" = 1
                "HideFirstRunExperience" = 1
                "DefaultBrowserSettingEnabled" = 0
                "CreateDesktopShortcutDefault" = 0
                "PersonalizationReportingEnabled" = 0
                "ShowRecommendationsEnabled" = 0
                "ConfigureDoNotTrack" = 1
                "DiagnosticData" = 0
                "EdgeAssetDeliveryServiceEnabled" = 0
            }
        } elseif ($State -eq "Disable") {
            $edgeValues = @{
                "NewTabPageContentEnabled" = $null
                "NewTabPageQuickLinksEnabled" = $null
                "SpotlightExperiencesAndRecommendationsEnabled" = $null
                "NewTabPageAllowedBackgroundTypes" = $null
                "ShowCastIconInToolbar" = $null
                "EnableMediaRouter" = $null
                "GamerModeEnabled" = $null
                "PasswordManagerEnabled" = $null
                "AutofillAddressEnabled" = $null
                "BrowserSignin" = $null
                "CryptoWalletEnabled" = $null
                "EdgeCollectionsEnabled" = $null
                "EdgeEDropEnabled" = $null
                "EdgeFollowEnabled" = $null
                "EdgeShoppingAssistantEnabled" = $null
                "EdgeWalletCheckoutEnabled" = $null
                "EdgeWalletEtreeEnabled" = $null
                "HubsSidebarEnabled" = $null
                "ShowMicrosoftRewards" = $null
                "SyncDisabled" = $null
                "NewTabPageBingChatEnabled" = $null
                "WalletDonationEnabled" = $null
                "BrowserAddProfileEnabled" = $null
                "EdgeDefaultProfileEnabled" = $null
                "MSAWebSiteSSOUsingThisProfileAllowed" = $null
                "AIGenThemesEnabled" = $null
                "PinBrowserEssentialsToolbarButton" = $null
                "SplitScreenEnabled" = $null
                "AutofillCreditCardEnabled" = $null
                "ImportPaymentInfo" = $null
                "PrintingEnabled" = $null
                "HideFirstRunExperience" = $null
                "DefaultBrowserSettingEnabled" = $null
                "CreateDesktopShortcutDefault" = $null
                "PersonalizationReportingEnabled" = $null
                "ShowRecommendationsEnabled" = $null
                "ConfigureDoNotTrack" = $null
                "DiagnosticData" = $null
                "EdgeAssetDeliveryServiceEnabled" = $null
            }
        }
        Write-Host "-----> Edge: setting properties..." -ForegroundColor Yellow
        foreach ($edgePath in $edgePaths) {
            foreach ($property in $edgeProperties.GetEnumerator()) {
                if ($edgeValues.ContainsKey($property.Name)) {
                    $value = $edgeValues[$property.Name]
                    if ($null -eq $value) {
                        Remove-ItemProperty -Path $edgePath -Name $property.Name -ErrorAction SilentlyContinue
                    } else {
                        New-ItemProperty -Path $edgePath -Name $property.Name -Value $value -PropertyType $(if ($value -is [string]) { "String" } else { "Dword" }) -Force | Out-Null
                    }
                }
            }
        }
        if ($null -eq $value) {
            Write-Host "-----> Edge: properties deleted" -ForegroundColor Green
        } else {
            Write-Host "-----> Edge Chrome: properties created" -ForegroundColor Green
        }
    } catch {
      Write-Warning $psitem.Exception.Message
    }
}