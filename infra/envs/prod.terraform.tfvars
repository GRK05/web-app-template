project_id = "web-pattern-prod-env-01"
domain     = "fern-template.elancosolutions.com"
is_dev     = false

apps = {
  "api-us-east4" = {
    container_url          = "grc.io/web-pattern-prod-env-01/api"
    tag                    = var.prod_web_image_tag
    region                 = "us-east4"
    needs_firestore_access = true
    container_port         = 8080
  },
  "web-us-east4" = {
    container_url          = "grc.io/web-pattern-prod-env-01/web"
    tag                    = var.prod_api_image_tag
    region                 = "us-east4"
    needs_firestore_access = false
    container_port         = 8080
  }
}

url_map_default = [
  "web-us-east4"
]

url_map = {
  "api" = [
    "api-us-east4"
  ]
}
