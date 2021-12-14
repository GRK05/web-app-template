variable "project_id" {
  type        = string
  description = "Project ID to land the pattern deployment"
}

variable "apps" {
  type        = map(any)
  description = "List of apps and properties to be deployed"
}

variable "url_map_default" {
  type = list(string)
}

variable "url_map" {
  type = map(any)
}


variable "domain" {
  type = string
}
