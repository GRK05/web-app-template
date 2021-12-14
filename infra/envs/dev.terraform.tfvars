project_id = "web-pattern-dev-env-01"
domain     = "fern-template-dev.elancosolutions.com"

apps = {
  "api-us-east4" = {
    container_url          = "grc.io/web-pattern-prod-env-01/api"
    tag                    = "latest"
    region                 = "us-east4"
    needs_firestore_access = true
    container_port         = 8080
  },
  "web-us-east4" = {
    container_url          = "grc.io/web-pattern-prod-env-01/web"
    tag                    = "latest"
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
