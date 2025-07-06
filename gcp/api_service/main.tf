resource "google_project_service" "api_service" {
  
  count = length(var.api_services)
  
  project                     = var.project_id  
  service                     = var.api_services[count.index]
  disable_on_destroy          = var.disable_on_destroy
  disable_dependent_services  = var.disable_dependent_services

}