/* ---------------------- Create the Container Registry --------------------- */

resource "google_container_registry" "registry" {
  count = var.is_dev ? 0 : 1

  project  = var.project_id
  location = "US"
}

/* -------------------------------------------------------------------------- */
/*                        Create the Cloud Run Services                       */
/* -------------------------------------------------------------------------- */

module "web_us_east_service" {
  source = "./modules/cloud_run_service"

  project_id             = var.project_id
  name                   = "web-us-east"
  region                 = "us-east4"
  needs_firestore_access = false
  container_url          = "gcr.io/web-pattern-prod-env-01/web:${var.is_dev ? var.dev_web_image_tag : var.prod_web_image_tag}"
  container_port         = "8080"
}

module "api_us_east_service" {
  source = "./modules/cloud_run_service"

  project_id             = var.project_id
  name                   = "api-us-east"
  region                 = "us-east4"
  needs_firestore_access = true
  container_url          = "gcr.io/web-pattern-prod-env-01/api:${var.is_dev ? var.dev_api_image_tag : var.prod_api_image_tag}"
  container_port         = "8080"
}

/* -------------------------------------------------------------------------- */
/*                          Create the Load Balancer                          */
/* -------------------------------------------------------------------------- */

module "global_load_balancer" {
  source = "./modules/load_balancer"

  project_id = var.project_id
  domain     = var.domain
  cloud_run_services = {
    "web_us_east_service" = module.web_us_east_service,
    "api_us_east_service" = module.api_us_east_service
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
