#!/bin/bash

EVENTGRID_NAME_01=""
EVENTGRID_NAME_02=""
SUBSCRIPTION_ID=""
RESOURCEGROUP_NAME=""
AZURE_FUNCTION_NAME=""
FUNCTION_NAME=""

echo "--------------------------------------------------------------------------------"
printf '%40s\n' "Creating Event Grid and Advanced Filter 01"
echo "--------------------------------------------------------------------------------"
az eventgrid event-subscription create --name "$EVENTGRID_NAME_01" \
--source-resource-id /subscriptions/$SUBSCRIPTION_ID \
--endpoint-type azurefunction \
--endpoint /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCEGROUP_NAME/providers/Microsoft.Web/sites/$AZURE_FUNCTION_NAME/functions/$FUNCTION_NAME \
--included-event-types Microsoft.Resources.ResourceWriteSuccess \
--advanced-filter data.authorization.action StringNotContains Microsoft.Resources/tags/write \
--advanced-filter data.operationName StringContains \
Microsoft.Compute/disks/write \
Microsoft.Compute/virtualMachines/write \
Microsoft.insights/metricalerts/write \
Microsoft.KeyVault/vaults/write \
Microsoft.RecoveryServices/vaults/write \
Microsoft.Storage/storageAccounts/write \
Microsoft.Compute/snapshots/write \
Microsoft.Datafactory/Factories/write \
Microsoft.Network/NetworkSecurityGroups/write  \
Microsoft.Network/privateDnsZones/write \
Microsoft.Network/privateEndpoints/write \
Microsoft.Network/publicIPAddresses/write \
Microsoft.Sql/servers/write \
Microsoft.Compute/images/write \
Microsoft.ContainerRegistry/registries/write \
Microsoft.Compute/virtualMachineScaleSets/write \
Microsoft.network/loadBalancers/write \
Microsoft.Network/networkWatchers/write \
Microsoft.operationalInsights/workspaces/write \
Microsoft.Network/networkInterfaces/write \
Microsoft.portal/dashboards/write \
Microsoft.web/serverFarms/write \
Microsoft.web/connections/write \
Microsoft.automation/automationAccounts/runbooks/write

echo "--------------------------------------------------------------------------------"
printf '%40s\n' "Creating Event Grid and Advanced Filter 02"
echo "--------------------------------------------------------------------------------"
az eventgrid event-subscription create --name "$EVENTGRID_NAME_02" \
--source-resource-id /subscriptions/$SUBSCRIPTION_ID \
--endpoint-type azurefunction \
--endpoint /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCEGROUP_NAME/providers/Microsoft.Web/sites/$AZURE_FUNCTION_NAME/functions/$FUNCTION_NAME \
--included-event-types Microsoft.Resources.ResourceWriteSuccess \
--advanced-filter data.authorization.action StringNotContains Microsoft.Resources/tags/write \
--advanced-filter data.operationName StringContains \
Microsoft.web/sites/write \
Microsoft.automation/automationAccounts/write \
Microsoft.certificateRegistration/certificateOrders/write \
Microsoft.cognitiveServices/accounts/write \
Microsoft.operationalInsights/queryPacks/write \
Microsoft.batch/batchAccounts/write \
Microsoft.logic/workflows/write \
Microsoft.insights/components/write \
Microsoft.operationsManagement/solutions/write \
Microsoft.network/virtualNetworks/write \
Microsoft.DataProtection/BackupVaults/write \
Microsoft.Compute/sshPublicKeys/write \
Microsoft.DBforPostgreSQL/servers/write \
Microsoft.Network/localnetworkgateways/write \
Microsoft.Network/virtualnetworkgateways/write \
Microsoft.Network/natgateways/write \
Microsoft.Network/applicationgateways/write