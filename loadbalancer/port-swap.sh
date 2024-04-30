#!/bin/bash

TARGET_RG_NAME=
TARGET_LB_NAME=
PROD_RULE_NAME=
PROD_PORT=
PROD_TEMP_PORT=
STAGE_RULE_NAME=
STAGE_PORT=

echo "---> Swap Load balancer Rule's Frontend Port"

# PROD to TEMP: 80 -> 8081
az network lb rule update -g $TARGET_RG_NAME --lb-name $TARGET_LB_NAME -n $PROD_RULE_NAME --frontend-port $PROD_TEMP_PORT --protocol "Tcp"

# STAGE to PROD: 8080 -> 80
az network lb rule update -g $TARGET_RG_NAME --lb-name $TARGET_LB_NAME -n $STAGE_RULE_NAME --frontend-port $PROD_PORT --protocol "Tcp"

# PROD to STAGE: 8081 -> 8080
az network lb rule update -g $TARGET_RG_NAME --lb-name $TARGET_LB_NAME -n $PROD_RULE_NAME --frontend-port $STAGE_PORT --protocol "Tcp"