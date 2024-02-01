resource "google_container_cluster" "helloweb3" {
  name     = "my-cluster"
  location = "us-central1"
  network  = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  initial_node_count = 1
  remove_default_node_pool = true
  addons_config {
    http_load_balancing {
        disabled = true
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name = "pod-range"
    service_secondary_range_name = "svc-range"
  }
}

resource "google_container_node_pool" "app_pool" {
  name     = "my-node-pool"
  location = "us-central1"
  cluster  = google_container_cluster.helloweb3.name
  node_count = 1

  node_config {
    machine_type = "e2-small"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "spot" {
  name     = "spot"
  location = "us-central1"
  cluster  = google_container_cluster.helloweb3.name
  autoscaling {
    min_node_count = 0 
    max_node_count = 10
  }

  node_config {
    preemtible = true
    machine_type = "e2-small"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}