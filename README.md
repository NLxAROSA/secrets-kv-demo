# Spring Boot and Azure Keyvault Secrets demo

## Prerequisites
- An active Azure subscription
- The Azure CLI installed on your local system (the setup script uses this)

## Running this application

The setup script will create the required items for you on Azure and will export the required details for the application into your environment. It will require some modification (setting up the variables) as mentioned below.

Note: the 

1. Edit the variables in the `setup_keyvault_local.sh` script to reflect your desired names for the keyvault. The following variables are required to be changed:

- `RESOURCE_GROUP_NAME` - The desired name of the Resource Group to create resources under.
- `KEYVAULT_NAME` - The desired name of the Keyvault to be created by the script.
- `SP_NAME` - The desired name of the Service Principal that will be usde to access the Keyvault.
- `SECRET_VALUE` - The desired value of the Secret that will be created.

2. Run the script using `. ./setup_keyvault_local.sh`. Notice the extra dot at the beginning to export environment variables into your current shell.
3. The script will create the KeyVault, a Service Principal and a Secret inside the Keyvault. The Policy for this key will be limited to the `list`, `set` and `get` operations.
4. Update the `application.yaml` file with the data from the generated `sp.json`. This is different from the signing demo because of config resolution.
4. Run the application using `./mvnw spring-boot:run`. You should see some output that shows the value of the secret that was injected into your application)
5. Great success!