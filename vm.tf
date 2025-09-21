resource "netbox_cluster_type" "proxmox" {
    name = "Proxmox"
}
resource "netbox_cluster" "odin_vms" {
    cluster_type_id = netbox_cluster_type.proxmox
    name = "odin_vms"
}
resource "netbox_cluster_type" "docker" {
    name = "Docker"
}
resource "netbox_cluster" "odin_mobydick_docker" {
    cluster_type_id = netbox_cluster_type.docker
    name = "odin_mobydick_docker"
}


/*
*   Virutal Machines
*/
resource "netbox_virtual_machine" "odin_int_router" {
    cluster_id = netbox_cluster.odin_vms.id
    description = "pfsense firewall for internal resources"
    name       = "int_router"

    disk_size_mb = 30000
    memory_mb = 2000
    vcpus = 1

    tags = [ "internal", "home_network", "cosmos" ]
}
resource "netbox_virtual_machine" "odin_mobydick" {
    cluster_id = netbox_cluster.odin_vms.id
    description = "host of docker container (cosmos)"
    name       = "mobydick"

    disk_size_mb = 32000
    memory_mb = 32000
    vcpus = 4

    tags = [ "internal", "cosmos" ]
}
resource "netbox_virtual_machine" "odin_school-lab" {
    cluster_id = netbox_cluster.odin_vms.id
    description = "VM for my school work"
    name       = "school-lab"

    disk_size_mb = 31250
    memory_mb = 8000
    vcpus = 2

    tags = [ "internal" ]
}

/*
*   Docker Containers
*/
resource "netbox_virtual_machine" "odin_mobydick_netbox" {
    cluster_id = netbox_cluster.odin_mobydick_docker.id
    description = "netbox used for homelab inventory"
    name = "netbox"

    tags = [ "docker_container" ]
}
resource "netbox_virtual_machine" "odin_mobydick_watchtower" {
    cluster_id = netbox_cluster.odin_mobydick_docker.id
    description = "watchtower used to keep containers up to date"
    name = "watchtower"

    tags = [ "docker_container" ]
}
resource "netbox_virtual_machine" "odin_mobydick_cloudflare" {
    cluster_id = netbox_cluster.odin_mobydick_docker.id
    description = "cloudflare tunnel used to access internal resources remotely"
    name = "cloudflare"

    tags = [ "docker_container", "cloudflare_tunnel" ]
}
resource "netbox_virtual_machine" "odin_mobydick_guac" {
    cluster_id = netbox_cluster.odin_mobydick_docker.id
    description = "guacamole used to access internal servers from web browser"
    name = "guacamole"

    tags = [ "docker_container", "cloudflare_tunnel" ]
}
resource "netbox_virtual_machine" "odin_mobydick_n8n" {
    cluster_id = netbox_cluster.odin_mobydick_docker.id
    description = "n8n used to automate tasks"
    name = "n8n"

    tags = [ "docker_container" ]
}
resource "netbox_virtual_machine" "odin_mobydick_pihole" {
    cluster_id = netbox_cluster.odin_mobydick_docker.id
    description = "pihole used to block ads and serve as dns"
    name = "pihole"

    tags = [ "docker_container" ]
}
resource "netbox_virtual_machine" "odin_mobydick_portainer" {
    cluster_id = netbox_cluster.odin_mobydick_docker.id
    description = "portainer used to monitor docker conatiner status from browser"
    name = "portainer"

    tags = [ "docker_container" ]
}
resource "netbox_virtual_machine" "odin_mobydick_slskd" {
    cluster_id = netbox_cluster.odin_mobydick_docker.id
    description = "slskd is a file sharing network"
    name = "slskd"

    tags = [ "docker_container" ]
}
resource "netbox_virtual_machine" "odin_mobydick_traefik" {
    cluster_id = netbox_cluster.odin_mobydick_docker.id
    description = "traefik used as reverse proxy to access docker services via fqdn"
    name = "traefik"

    tags = [ "docker_container" ]
}