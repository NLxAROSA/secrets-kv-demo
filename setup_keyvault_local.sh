#!/bin/bash

RESOURCE_GROUP="lroSecretsRG"
RESOURCE_GROUP_REGION="EastUS"
KEYVAULT_NAME="lroSecretsKv"
SP_NAME="http://lroSecretsSp"
SECRET_NAME="lroSecretName"
SECRET_VALUE="'This is extremely secret'"

echo "Creating resource group..."
az group create -n $RESOURCE_GROUP -l $RESOURCE_GROUP_REGION
echo "Creating Keyvault..."
az keyvault create -n $KEYVAULT_NAME -g $RESOURCE_GROUP
echo "Creating Service Principal..."
az ad sp create-for-rbac -n $SP_NAME --sdk-auth > sp.json
echo "Setting policy..."
az keyvault set-policy -n $KEYVAULT_NAME --spn $SP_NAME --secret-permissions list set get delete
echo "Creating secret..."
az keyvault secret set --name $SECRET_NAME --vault-name $KEYVAULT_NAME --value $SECRET_VALUE
echo "Exporting environment variables"
for keyval in $(grep -E '": [^\{]' sp.json | sed -e 's/: /=/' -e "s/\(\,\)$//" | sed 's/\"//g'); do
    echo "export $keyval"
    export $keyval
done
az keyvault key list --vault-name $KEYVAULT_NAME > key.json
for keyval in $(grep -E '": [^\{]' key.json | sed -e 's/: /=/' -e "s/\(\,\)$//" | sed 's/\"//g'); do
    echo "export $keyval"
    export $keyval
done