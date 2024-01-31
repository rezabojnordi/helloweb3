resource "google_compute_network" "NAME" {
  name                    = "NAME"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "NAME" {
  name                     = 
  ip_cidr_range            = 
  network                  = 
  private_ip_google_access = true
  region                   = 

  secondary_ip_range {
    range_name    = 
    ip_cidr_range = 
  }

  secondary_ip_range {
    range_name    = 
    ip_cidr_range = 
  }
}



###Aditional configuration candidate might fined usefull to add
