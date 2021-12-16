project_id                    = "web-pattern-dev-env-01"
container_registry_project_id = "web-pattern-prod-env-01"
domain                        = "fern-template-dev.elancosolutions.com"
is_dev                        = true

url_map_default = [
  "web-us-east-service"
]

url_map = {
  "api" = [
    "api-us-east-service"
  ]
}
