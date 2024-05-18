variable "aks_rg_name" {
  type        = string
  description = "RG name in Azure"
}

variable "aks_location" {
  type        = string
  description = "Resources location in Azure"
}

variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}

variable "system_node_size" {
  type        = string
  description = "Size of each AKS worker node"
}

variable "node_resource_group" {
  type        = string
  description = "RG name for cluster resources in Azure"
}

variable "acr_name" {
  type        = string
  description = "Name of the ACR"
}

variable "acr_rg_name" {
  type        = string
  description = "Resource group name of the ACR"
}

variable "jenkins_vm_size" {
  type        = string
  description = "Size of Jenkins VM"
}

variable "jenkins_vm_location" {
  type        = string
  description = "Region of Jenkins VM"
}

variable "jenkins_rg_name" {
  type        = string
  description = "Resource group name of Jenkins VM"
}

/*variable "acr_geo_replicaton_location_1" {
  type        = string
  description = "Geo replication location - 1"
}*/

variable "tag_billing_team" {
  type        = string
  description = "Tag to identify the billing team"
}

variable "tag_env" {
  type        = string
  description = "Tag to identify the environment"
}

/*variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}*/