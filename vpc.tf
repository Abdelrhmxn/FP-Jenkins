resource "google_compute_network" "mynetwork" {
  name                    = "project-network"
  auto_create_subnetworks = false
} 

# ----------------------------------------------------
resource "google_compute_subnetwork" "management-subnet" {
  name          = "management-subnet"
  ip_cidr_range = var.cidr-management-subnet
  region        = var.region-management-subnet
  network       = google_compute_network.mynetwork.id
}

# ------------------------------------------------------
resource "google_compute_router" "router" {
  project = var.project
  name    = "nat-router"
  network = google_compute_network.mynetwork.id
  region  = var.region-management-subnet
}


resource "google_compute_router_nat" "cloud-nat" {
  name                               = "cloud-router-nat"
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.management-subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

# ---------------------------------------------------------
resource "google_compute_firewall" "vm-rules" {
  project = var.project
  name    = "allow-ssh"
  network = google_compute_network.mynetwork.id

  allow {
    protocol = "tcp"
    ports    = ["22","80","8080"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["jenkins-vm"]
}

 
