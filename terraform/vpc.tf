
# Ensure google compute service enabled
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

# create a vpc without automated subnet to manage router and nat to get access to cluster
resource "google_compute_network" "vpc" {
  name                    = "my-vpc"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}


# Create Subnet for Pod and Service CIDR separately. You can Create bigger or smaller range base on your need. 
resource "google_compute_subnetwork" "subnet" {
  name                     = "my-subnet"
  ip_cidr_range            = "10.0.0.0/16"
  network                  = google_compute_network.vpc.name
  private_ip_google_access = true
  region                   = "us-central1"

  secondary_ip_range {
    range_name    = "pod-range"
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = "svc-range"
    ip_cidr_range = "10.2.0.0/20"
  }
}


# Add VPC to a new Router to access Internet
resource "google_compute_router" "router" {
  name = "router"
  region = "us-central1"
  network = google_compute_network.vpc.name
}


# Availabe Nat to add internete to all SUbnets and IPs
resource "google_compute_router_nat" "nat" {
  name = "nat"
  router = google_compute_router.router.name
  region = "us-central1"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option = "MANUAL_ONLY"

  subnetwork {
    name = google_compute_subnetwork.subnet.name
    source_ip_range_to_nat = ["ALL_IP_RANGES"]
  }
  nat_ips = [google_compute_address.nat.self_link]

}

resource "google_compute_address" "nat" {
  name = "nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  depends_on = [google_project_service.compute] 

}


# I was System administrator before So I Like to access server via SSH but it is not necessary :)
resource "google_compute_firewall" "allow-ssh" {
  name = "allow-ssh"
  network = google_compute_network.vpc.name
  allow  {
    protocol = "tcp"
    ports = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}
