#!/bin/bash

# Login with Service Principal
echo "--------------------------------------------------------------------------------"
printf '%40s\n' "Login with Service Principal"
echo "--------------------------------------------------------------------------------"

app_id=$1
app_secret=$2
tenant_id=$3
subscription_id=$4

az login --service-principal -u $app_id -p $app_secret --tenant $tenant_id
az account set --subscription $subscription_id

# Check available VM Size 
echo "--------------------------------------------------------------------------------"
printf '%40s\n' "Check available VM Size"
echo "--------------------------------------------------------------------------------"

resource_group=$5
vm_name=$6
target_size=$7

isSizeAvailable=$(az vm list-vm-resize-options --resource-group $resource_group --name $vm_name --query "[?contains(name,'$target_size')].{name:name}" -o tsv)
if [ -z $isSizeAvailable ] # Empty == Unvailable
then
    echo "================================================================================"
    printf '%40s\n' "$target_size size is Unavailable"
    echo "================================================================================"
    exit 1;
fi
echo "--------------------------------------------------------------------------------"
printf '%40s\n' "$target_size size is Available"
echo "--------------------------------------------------------------------------------"

# Start VM Resize
echo "--------------------------------------------------------------------------------"
printf '%40s\n' "VM Size Change Start"
echo "--------------------------------------------------------------------------------"
az vm resize --resource-group $resource_group --name $vm_name --size $target_size

# 1 == False / 0 == True
isSizeChanged=$?
if [ isSizeChanged == 1 ]
then
    echo "================================================================================"
    printf '%40s\n' " Error Occured, Require admin check. "
    echo "================================================================================"
    exit 1;
fi
echo "--------------------------------------------------------------------------------"
printf '%40s\n' "Job Completed."
echo "--------------------------------------------------------------------------------"