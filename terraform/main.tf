terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "lab" {
  name = "bytown-net-${var.seed}"
}

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = true
}

resource "docker_container" "web" {
  count = var.instances
  name  = "bytown-tf-${var.seed}-${count.index}"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.base_port + var.seed + count.index
  }

  networks_advanced {
    name = docker_network.lab.name
  }

  upload {
    file    = "/usr/share/nginx/html/index.html"
    content = "<h1>Bytown NetOps</h1><p>Seed: ${var.seed}, instance: ${count.index}</p>\n"
  }
}
