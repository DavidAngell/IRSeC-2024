﻿# Set the execution policy temporarily to unrestricted to allow this script to run
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

# Define output file path
$outputFile = "C:\PasswordChangeResults.txt"

# Function to generate a random password
function Generate-RandomPassword {
    param (
        [int]$length = 20
    )
    
    # Check if the length is valid
    if ($length -lt 1) {
        throw "Password length must be at least 1 character."
    }

    # Define the character set to include uppercase, lowercase, digits, and special characters
    $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{};:,.<>?`~"
    
    # Generate the password by selecting random characters from the set
    $password = -join (1..$length | ForEach-Object { $chars[(Get-Random -Minimum 0 -Maximum $chars.Length)] })
    
    return $password
}

# Clear the output file if it already exists
if (Test-Path $outputFile) {
    Clear-Content $outputFile
}

# Function to change password for local users
function Change-LocalUserPasswords {
    # Get all local user accounts
    $users = Get-LocalUser

    # Loop through each user and change their password
    foreach ($user in $users) {
        # Skip the built-in accounts to avoid locking yourself out
        if ($user.Name -ne "Administrator" -and $user.Name -ne "Guest") {
            # Generate a random password
            $newPassword = Generate-RandomPassword

            # Change the user's password
            try {
                $password = ConvertTo-SecureString -String $newPassword -AsPlainText -Force
                Set-LocalUser -Name $user.Name -Password $password

                # Log the new password to the output file
                Add-Content -Path $outputFile -Value "Local User: $($user.Name) - New Password: $newPassword"
            }
            catch {
                # Log any errors to the output file
                Add-Content -Path $outputFile -Value "Failed to change password for local user: $($user.Name). Error: $_"
            }
        }
    }
}

# Function to change password for domain users
function Change-DomainUserPasswords {
    # Get all domain user accounts
    $domainUsers = Get-ADUser -Filter * -Properties SamAccountName

    # Loop through each domain user and change their password
    foreach ($user in $domainUsers) {
        # Skip the built-in accounts to avoid locking yourself out
        if ($user.SamAccountName -ne "Administrator" -and $user.SamAccountName -ne "Guest") {
            # Generate a random password
            $newPassword = Generate-RandomPassword

            # Change the user's password
            try {
                $securePassword = ConvertTo-SecureString -String $newPassword -AsPlainText -Force
                # Remove the -Force parameter
                Set-ADAccountPassword -Identity $user.SamAccountName -NewPassword $securePassword

                # Log the new password to the output file
                Add-Content -Path $outputFile -Value "Domain User: $($user.SamAccountName) - New Password: $newPassword"
            }
            catch {
                # Log any errors to the output file
                Add-Content -Path $outputFile -Value "Failed to change password for domain user: $($user.SamAccountName). Error: $_"
            }
        }
    }
}

# Change passwords for local users
Change-LocalUserPasswords

# Change passwords for domain users
Change-DomainUserPasswords

Write-Output "Password change results saved to $outputFile"

# Reinstate the execution policy to restricted after running the script
Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope Process
Write-Output "Execution policy set back to Restricted."