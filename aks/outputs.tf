resource "local_file" "kubeconfig" {
  depends_on = [module.azurerm_kubernetes_cluster_1]
  filename = "kubeconfig"
  content = module.azurerm_kubernetes_cluster_1.kube_config_raw
}