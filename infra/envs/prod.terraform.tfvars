project_id = "web-pattern-prod-env-01"
domain     = "fern-template.elancosolutions.com"
is_dev     = false

url_map_default = [
  "web-us-east-service"
]

url_map = {
  "api" = [
    "api-us-east-service"
  ]
}
