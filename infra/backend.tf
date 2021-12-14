terraform {
  cloud {
    organization = "elanco_animal_health"

    workspaces {
      name = "solops-appexcellence-template-web-fern"
    }
  }
}
