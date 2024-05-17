module "resource_groups_jenkins" {
  source = "../../azure/terraforms/modules/resource_group"
  name     = var.jenkins_rg_name 
  location = var.jenkins_vm_location
}

module "virtual_networks_jenkins" {
  source = "../../azure/terraforms/modules/virtual_network"
  prefix   = var.jenkins_rg_name
  location = var.jenkins_vm_location
  rsg      = module.resource_groups_jenkins.rsg
}

module "virtual_machine_jenkins" {
  source = "../../azure/terraforms/modules/virtual_machine"
  location        = var.jenkins_vm_location
  rsg             = module.resource_groups_jenkins.rsg
  subnet_internal = module.virtual_networks_jenkins.subnet_internal
  vm_size         = var.jenkins_vm_size
  prefix          = var.jenkins_rg_name  
}

module "resource_groups_aks" {
  source = "../../azure/terraforms/modules/resource_group"
  name     = var.aks_rg_name 
  location = var.aks_location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.aks_location
  resource_group_name = module.resource_groups_aks.rsg.name
  dns_prefix          = var.cluster_name
  node_resource_group = var.node_resource_group

  default_node_pool {
    name       = "system"
    node_count = var.system_node_count
    vm_size    = var.system_node_size
    type       = "VirtualMachineScaleSets"
    # availability_zones  = [1, 2, 3]
    enable_auto_scaling = false
  }
  /*linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }*/
  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet" # azure (CNI)
  }

  tags = {
    Billing = var.tag_billing_team
    Environment = var.tag_env
  }  
}

resource "azurerm_container_registry" "aks" {
  name                = var.acr_name
  resource_group_name = module.resource_groups_aks.rsg.name
  location            = module.resource_groups_aks.rsg.location
  sku                 = "Standard" # use Premium for geo replication
  admin_enabled       = false
  /*georeplications {
    location                = var.acr_geo_replicaton_location_1 # cannot be same location as ACR location
    zone_redundancy_enabled = true
    tags                    = {
      Billing = var.tag_billing_team
      Environment = var.tag_env
    }
  }*/
  /*georeplications {
      location                = "North Europe"
      zone_redundancy_enabled = true
      tags                    = {}
  }*/
}
// Note: Assigning roles in this way need a special previlege of "Owner" for the principal on behalf of which
// this role assignment is being peformed, i.e, 
resource "azurerm_role_assignment" "aks" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.aks.id
  skip_service_principal_aad_check = true
}

