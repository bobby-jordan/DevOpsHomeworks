provider "docker" {
    host = "tcp://192.168.99.100"
}

resource "docker_image" "img-web" {
    name = "shekeriev/terraform-docker:latest"
}