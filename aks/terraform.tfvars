jenkins_vm_size                  = "Standard_DS1_v2"
jenkins_vm_location              = "East US 2"
jenkins_rg_name                  = "rsg-raptor-jenkins"
jenkins_setup_script	         = "jenkins-setup-script.yaml"

aks_rg_name                      = "rsg-raptor-aks"
aks_location                     = "East US"

cluster_name                     = "aks-raptor"
kubernetes_version               = "1.28.9"
system_node_count                = 2
system_node_size                 = "Standard_DS2_v2"
node_resource_group              = "rsg-raptor-workers"

acr_name                         = "RaptorRegistry1"
acr_rg_name                      = "rsg-raptor-acr"
//acr_geo_replicaton_location_1  = "West US"

tag_billing_team                 = "raptor"
tag_env                          = "development"
