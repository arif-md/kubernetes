1) Install Azure CLI, terraforms and kubectl
2) Create a Service Principal, assign the role "Contributor" and set the following environment variables.
    - ARM_SUBSCRIPTION_ID
    - ARM_CLIENT_ID
    - ARM_CLIENT_SECRET
    - ARM_TENANT_ID
3) Execute the commands from commands.sh to create the infrastructure
4) Configure kubectl
    - Get k8s cluster credentials by logging into Azure k8s services console and navigating to kubernetes service => connect
    - az aks get-credentials --resource-group rsg-raptor-main --name aks-raptor --overwrite-existing
5) Start using the cluster 
    - kubectl get nodes
