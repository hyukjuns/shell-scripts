#!/bin/bash

appName=""
rgName=""
appSacName=""

# Create StorageAccount

# Create Azure Function
az functionapp create --name $appName \
--resource-group $rgName \
--storage-account $appSacName \
--functions-version 4 \
--runtime "powershell" \
--runtime-version "7.2" \
--os-type "Windows" \
--consumption-plan-location "koreacentral" \
--assign-identity "System" \
--role "Tag Contributor" 

# Create Function