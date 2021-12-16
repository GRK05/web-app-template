variable "project_id" {
  type        = string
  description = "Project ID to land the pattern deployment"
}

variable "container_registry_project_id" {
  type = string
}

variable "is_dev" {
  type        = bool
  description = "Denotes if the environment is dev or not"
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

variable "web_image_tag" {
  type = string
}

variable "api_image_tag" {
  type = string
}
