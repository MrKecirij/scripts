##########################
# This script will prompt you to enter your password securely (the characters won't be visible as you type).
# After you enter the password, it will convert it into a secure string and then into a hashed representation.
# You can then use this hashed password in your PowerShell script.
#
# Make sure to securely store this hashed password as it can be decrypted back to the original plain text
# only on the same machine and under the same user context. 
# Also, ensure that the user running the script has the necessary permissions to access and decrypt 
# the hashed password.
##########################
#
# (c) Jiří Modr, 2024, v1 with ChatGPT4 support

# dialog promt for secret inputing your password
$Password = Read-Host -Prompt "Enter your password" -AsSecureString

# hashing your password
$SecureString = ConvertFrom-SecureString -SecureString $Password

# showing secured hash of your password
Write-Output "Hashed password: $SecureString"