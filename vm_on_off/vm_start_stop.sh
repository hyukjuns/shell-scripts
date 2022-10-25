#!/bin/bash

rg_name=$1
vm_name=$2

vm_state=$(az vm show -g $rg_name -n $vm_name -d --query 'powerState' -o tsv | tr -d '\015')

if [[ $vm_state == "VM running" ]]
then
    az vm stop -n $vm_name -g $rg_name
    echo "VM Stopped"
elif [[ $vm_state == "VM stopped" ]]
then
    az vm start -n $vm_name -g $rg_name
    echo "VM Started"
else
    echo "Unkown state"
fi