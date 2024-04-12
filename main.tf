module "backend" {
  source = "./backend"
}

module "network" {
  source = "./network"
}

module "akscluster" {
  source = "./akscluster"
}

module "remix" {
  source = "./remix"
}
