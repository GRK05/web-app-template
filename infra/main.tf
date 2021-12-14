/* ---------------------- Create the Container Registry --------------------- */

resource "google_container_registry" "registry" {
  project  = var.project_id
  location = "US"
}

/* -------------------------------------------------------------------------- */
/*                        Create the Cloud Run Services                       */
/* -------------------------------------------------------------------------- */

module "cloud_run_services" {
  source   = "./modules/cloud_run_service"
  for_each = var.apps

  project_id             = var.project_id
  name                   = each.key
  container_url          = "${each.value.container_url}:${each.value.tag}"
  needs_firestore_access = each.value.needs_firestore_access
  region                 = each.value.region
  container_port         = each.value.container_port
}

/* -------------------------------------------------------------------------- */
/*                          Create the Load Balancer                          */
/* -------------------------------------------------------------------------- */

module "global_load_balancer" {
  source = "./modules/load_balancer"

  project_id         = var.project_id
  domain             = var.domain
  apps               = var.apps
  cloud_run_services = module.cloud_run_services
  url_map_default    = var.url_map_default
  url_map            = var.url_map
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
