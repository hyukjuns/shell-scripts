#!/bin/bash

echo "--------------------------------------------------------------------------------"
printf '%40s\n' "Updating Event Grid Advanced Filter"
echo "--------------------------------------------------------------------------------"
az eventgrid event-subscription update --name "<EVENTGRID_NAME>" \
--source-resource-id /subscriptions/<SUBID> \
--advanced-filter data.status StringContains Succeeded \
--advanced-filter data.authorization.action StringContains \
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
printf '%40s\n' "Creating Event Grid and Advanced Filter"
echo "--------------------------------------------------------------------------------"
az eventgrid event-subscription create --name "<EVENTGRID_NAME>" \
--source-resource-id /subscriptions/<SUBID> \
--endpoint-type azurefunction \
--endpoint /subscriptions/<SUBID>/resourceGroups/<RG_NAME>/providers/Microsoft.Web/sites/<FUNCTION_NAME>/functions/<TRIGGER_NAME> \
--included-event-types Microsoft.Resources.ResourceWriteSuccess \
--advanced-filter data.status StringContains Succeeded \
--advanced-filter data.authorization.action StringIn \
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
Microsoft.DBforPostgreSQL/servers/write