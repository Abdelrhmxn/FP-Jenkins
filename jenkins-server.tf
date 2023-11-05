resource "google_service_account" "jenkins-sa" {
  account_id   = "jenkins-sa"
  display_name = "Service Account For Management-VM To Control GKE Cluster And Artifact Registry"
}

resource "google_project_iam_member" "connnect-gke" {
  project = var.project
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.jenkins-sa.email}"
}



#------------------------------------------------------------------
#------------------------------------------------------------------
#------------------------------------------------------------------
resource "google_compute_instance" "jenkins-vm" {
  name                      = "jenkins-vm"
  machine_type              = var.type-vm
  zone                      = var.zone-vm
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = var.image-vm
    }
  }

  network_interface {
    network    = google_compute_network.mynetwork.id
    subnetwork = google_compute_subnetwork.management-subnet.id
    access_config {}
  }
  tags = ["jenkins-vm"]

  service_account {
    email  = google_service_account.jenkins-sa.email
    scopes = ["cloud-platform"]
  }


}

#------------------------------------------------------

 
