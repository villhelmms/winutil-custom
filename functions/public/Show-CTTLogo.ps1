Function Show-CTTLogo {
    <#
        .SYNOPSIS
            Displays the CTT logo in ASCII art.
        .DESCRIPTION
            This function displays the CTT logo in ASCII art format.
        .PARAMETER None
            No parameters are required for this function.
        .EXAMPLE
            Show-CTTLogo
            Prints the CTT logo in ASCII art format to the console.
    #>

    $asciiArt = @"
====Chris Titus Tech=====
=====Windows Toolbox=====
"@

    Write-Host $asciiArt
}

