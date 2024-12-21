<#
    .SYNOPSIS
    Example PowerShell script

    .DESCRIPTION
    Take a number, multiply it by 3, and write out the result.
#>

param(
    # Number to multiply by 3
    [Parameter(Mandatory=$true)]
    [int] $Number
)

$Number * 3
