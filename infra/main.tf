/* ---------------------- Create the Container Registry --------------------- */

resource "google_container_registry" "registry" {
  count = var.is_dev ? 0 : 1

  project  = var.project_id
  location = "US"
}

/* -------------------------------------------------------------------------- */
/*                        Create the Cloud Run Services                       */
/* -------------------------------------------------------------------------- */

module "web-us-east-service" {
  source = "./modules/cloud_run_service"

  project_id                    = var.project_id
  name                          = "web-us-east"
  region                        = "us-east4"
  needs_firestore_access        = false
  container_url                 = "gcr.io/${var.container_registry_project_id}/web:${var.web_image_tag}"
  container_port                = "8080"
  container_registry_project_id = var.container_registry_project_id
}

module "api-us-east-service" {
  source = "./modules/cloud_run_service"

  project_id                    = var.project_id
  name                          = "api-us-east"
  region                        = "us-east4"
  needs_firestore_access        = true
  container_url                 = "gcr.io/${var.container_registry_project_id}/api:${var.api_image_tag}"
  container_port                = "8080"
  container_registry_project_id = var.container_registry_project_id
}

/* -------------------------------------------------------------------------- */
/*                          Create the Load Balancer                          */
/* -------------------------------------------------------------------------- */

module "global_load_balancer" {
  source = "./modules/load_balancer"

  project_id = var.project_id
  domain     = var.domain
  cloud_run_services = {
    "web-us-east-service" = module.web-us-east-service,
    "api-us-east-service" = module.api-us-east-service
  }
  url_map_default = var.url_map_default
  url_map         = var.url_map
}

/* ------------------- DNS Entry in shared (temp) project ------------------- */

resource "google_dns_record_set" "dns_record" {
  project      = "temp-dns-shared-project-001"
  name         = "${var.domain}."
  type         = "A"
  ttl          = 300
  managed_zone = "elancosolutions-com"
  rrdatas = [
    module.global_load_balancer.address
  ]
}

/* -------------------------------------------------------------------------- */
/*                       Create the Firestore instances                       */
/* -------------------------------------------------------------------------- */

module "firestore" {
  source = "./modules/firestore"

  project_id = var.project_id
}
