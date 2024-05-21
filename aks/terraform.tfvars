jenkins_vm_size                            = "Standard_DS1_v2"
jenkins_vm_location                        = "East US 2"
jenkins_rg_name                            = "raptor-jenkins"
jenkins_setup_script	                   = "jenkins-setup-script.yaml"
jenkins_vm_admin_username                  = "devops"
jenkins_vm_admin_password                  = null
jenkins_vm_image_publisher                 = "Canonical"
jenkins_vm_image_offer                     = "0001-com-ubuntu-server-focal"
jenkins_vm_image_sku                       = "20_04-lts"
jenkins_vm_image_ver                       = "latest"
jenkins_vm_disable_password_authentication = true

aks_rg_name                      = "raptor-aks"
aks_location                     = "East US"

cluster_name                     = "raptor-k8s-cluster"
kubernetes_version               = "1.28.9"
system_node_count                = 2
system_node_size                 = "Standard_DS2_v2"
node_resource_group              = "raptor-k8s-workers"

acr_name                         = "RaptorRegistry1"
acr_rg_name                      = "raptor-acr"
//acr_geo_replicaton_location_1  = "West US"

tag_billing_team                 = "raptor"
tag_env                          = "development"
