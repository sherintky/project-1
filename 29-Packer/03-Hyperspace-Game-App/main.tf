
//
// INSTANCES
//
resource "google_compute_instance" "hyperspace" {
  name         = "hyperspace"
  machine_type = "n1-standard-1"
  zone         = "us-west1-a"
  tags = ["hyperspace"]

  boot_disk {
    initialize_params {
      image = "hyperspace-1601803929"
    }
  }

  network_interface {
      network = "default"
      access_config {
          // Ephemeral IP
      }
  }
  count = 1
}

//
// NETWORKING
//
resource "google_compute_firewall" "fwrule" {
    name = "hyperspace-web"
    network = "default"
    allow {
        protocol = "tcp"
        ports = ["80"]
    }
    target_tags = ["hyperspace"]
}

