terraform {
  backend "remote" {
    organization = "Frostline"
    workspaces {
      name = "hetzner"
    }
  }
}