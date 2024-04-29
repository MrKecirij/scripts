# Define the credentials for the remote server
$Username = "insim\lsabt04mr"
$Password = "hashed_password"  # Make sure to hash the password by rules and script at 00_hash_your_password.ps1
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username, $SecurePassword

# define the time stamp
$WhenStarted = Get-DateGet-Date -Format yy-MM-dd_HH-mm-SS

# Read the list of items from the CSV file
$Items = Import-Csv -Path "10_input_items_list.csv" -Delimiter ";" | ForEach-Object {
    [PSCustomObject]@{
        ItemID = $_.ItemID
        Source = $_.Source
        Target = $_.Target
        Port = $_.Port
        Type = $_.Type
        Name = $_.Name
    }
}

# Loop through each item and test the port remotely
foreach ($Item in $Items) {
    $ItemID = $Item.ItemID
    $Source = $Item.Source
    $Target = $Item.Target
    $Port = $Item.Port
    $Type = $Item.Type
    $Name = $Item.Name

    # Test the port remotely
    $Result = Test-NetConnection -ComputerName $Target -Port $Port -Credential $Credential

    # Check if the port is open
    if ($Result.TcpTestSucceeded) {
        $Status = "OPEN ;o)"
    } else {
        $Status = "BROKEN ;-/"
    }

    # Output the results to the screen
    Write-Output "ItemID: $ItemID | Source: $Source | Target: $Target | Type: $Type | Name: $Name | Port: $Port | Status: $Status"

    # Optionally, create a text document with the output
    $Output = [PSCustomObject]@{
        TestRun = $WhenStarted
        ItemID = $ItemID
        Source = $Source
        Target = $Target
        Type = $Type
        Name = $Name
        Port = $Port
        Status = $Status
    }
    $Output | Export-Csv -Path "90_test_output.csv" -Delimiter ";" -Append -NoTypeInformation
}