terraform {
  required_providers {
    cloudflare = {
      source = "terraform-providers/cloudflare"
    }
    digitalocean = {
      source = "terraform-providers/digitalocean"
    }
  }
}

variable "digitalocean_token" {}
variable "cloudflare_api_token" {}


provider "digitalocean" {
  token = var.digitalocean_token
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

locals {
  web_count = 2
  zone_id   = "f2c00168a7ecd694bb1ba017b332c019"
}

data "digitalocean_ssh_key" "ondrejsika" {
  name = "ondrejsika"
}

resource "digitalocean_droplet" "proxy" {
  image  = "debian-10-x64"
  name   = "proxy"
  region = "fra1"
  size   = "s-4vcpu-8gb"
  ssh_keys = [
    data.digitalocean_ssh_key.ondrejsika.id
  ]

  connection {
    user = "root"
    type = "ssh"
    host = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt-get -y install python3 python3-pip",
    ]
  }
}

resource "cloudflare_record" "proxy" {
  zone_id = local.zone_id
  name    = "proxy"
  value   = digitalocean_droplet.proxy.ipv4_address
  type    = "A"
  proxied = false
}

resource "digitalocean_droplet" "web" {
  count = local.web_count

  image  = "debian-10-x64"
  name   = "web${count.index}"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.ondrejsika.id
  ]

  connection {
    user = "root"
    type = "ssh"
    host = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt-get -y install python3 python3-pip"
    ]
  }
}

resource "cloudflare_record" "web" {
  count = local.web_count

  zone_id = local.zone_id
  name    = "web${count.index}"
  value   = digitalocean_droplet.web[count.index].ipv4_address
  type    = "A"
  proxied = false
}

output "ansible-hosts" {
  value = {
    "proxy" = {
      "hosts" = [
        cloudflare_record.proxy.hostname
      ]
    }
    "web" = {
      "hosts" = cloudflare_record.web.*.hostname
    }
  }
}
