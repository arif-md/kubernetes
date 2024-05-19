module "resource_groups_jenkins" {
  source     = "../../azure/terraforms/modules/resource_group"
  name       = var.jenkins_rg_name 
  location   = var.jenkins_vm_location
}

module "virtual_networks_jenkins" {
  source     = "../../azure/terraforms/modules/virtual_network"
  prefix     = var.jenkins_rg_name
  location   = var.jenkins_vm_location
  rsg        = module.resource_groups_jenkins.rsg
}

module "virtual_machine_jenkins" {
  source          = "../../azure/terraforms/modules/virtual_machine"
  location        = var.jenkins_vm_location
  rsg             = module.resource_groups_jenkins.rsg
  subnet_internal = module.virtual_networks_jenkins.subnet_internal
  vm_size         = var.jenkins_vm_size
  prefix          = var.jenkins_rg_name  
  init_script     = var.jenkins_setup_script
  assign_public_ip= true
}

locals {
  jenkins_public_ip = module.virtual_machine_jenkins.public_ip
}


module "azurerm_kubernetes_cluster_1" {
  source              = "../../azure/terraforms/modules/aks_cluster"
  location            = var.aks_location
  rg_name             = var.aks_rg_name
  cluster_name        = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  
  node_resource_group = var.node_resource_group
  system_node_size    = var.system_node_size
  system_node_count   = var.system_node_count
  tag_billing_team    = var.tag_billing_team
  tag_env             = var.tag_env
} 

module "azurerm_container_registry_1" {
  source = "../../azure/terraforms/modules/container_registry"
  location        = var.aks_location
  rg_name             = var.acr_rg_name
  acr_name       = var.acr_name
  aks_principal_id = module.azurerm_kubernetes_cluster_1.aks_principal_id
  tag_billing_team = var.tag_billing_team
  tag_env = var.tag_env
}
