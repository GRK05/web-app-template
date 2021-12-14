variable "project_id" {
  type        = string
  description = "Project ID to land the pattern deployment"
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

variable "dev_web_image_tag" {
  type = string
}

variable "dev_api_image_tag" {
  type = string
}

variable "prod_web_image_tag" {
  type = string
}

variable "prod_api_image_tag" {
  type = string
}
