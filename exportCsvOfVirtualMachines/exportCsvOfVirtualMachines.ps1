### PREREQUISITES START ###
#
# In order for this script to work, you'll need to be signed into your Azure Environment.
# You can do this by running the following command:
# Connect-AzAccount
# For more information, see https://docs.microsoft.com/en-us/powershell/azure/authenticate-azureps
#
### PREREQUISITES END ###

# Define the output CSV file path (adjust for macOS)
$outputFile = "~/Desktop/All_Subscriptions_VM_Names.csv"

# Initialize an array to store VM details
$allVMs = @()

# Get all subscriptions in the tenant
$subscriptions = Get-AzSubscription

# Loop through each subscription
foreach ($subscription in $subscriptions) {
    # Set the current subscription
    Set-AzContext -SubscriptionId $subscription.Id

    # Get all VMs in the current subscription
    $vms = Get-AzVM

    # Add VM details to the array
    $allVMs += $vms | Select-Object -Property Name
}

# Export the aggregated VM details to CSV
$allVMs | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

# Confirm completion
Write-Host "Exported VM details from all subscriptions to $outputFile"