variable "do_token" {}
variable "cloudflare_email" {}
variable "cloudflare_token" {}

variable "web_vm_count" {
  default = 2
}
variable "proxy_vm_count" {
  default = 2
}

provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  version = "~> 1.0"
  email = var.cloudflare_email
  token = var.cloudflare_token
}


data "digitalocean_ssh_key" "ondrejsika" {
  name = "ondrejsika"
}

resource "digitalocean_droplet" "web" {
  count = var.web_vm_count

  image  = "debian-10-x64"
  name   = "web${count.index}"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.ondrejsika.id
  ]
}

resource "cloudflare_record" "web" {
  count = var.web_vm_count

  domain = "sikademo.com"
  name   = "web${count.index}"
  value  = digitalocean_droplet.web[count.index].ipv4_address
  type   = "A"
  proxied = false
}

resource "digitalocean_droplet" "proxy" {
  count = var.proxy_vm_count

  image  = "debian-10-x64"
  name   = "proxy${count.index}"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.ondrejsika.id
  ]
}

resource "cloudflare_record" "proxy" {
  count = var.proxy_vm_count

  domain = "sikademo.com"
  name   = "proxy${count.index}"
  value  = digitalocean_droplet.proxy[count.index].ipv4_address
  type   = "A"
  proxied = false
}
