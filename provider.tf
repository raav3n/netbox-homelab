terraform {
    required_providers {
        netbox = {
            source  = "e-breuninger/netbox"
            version = "~> 5.0   "
        }
    }
}

provider "netbox" {
    server_url = "https://netbox.cosmos.com"
    api_token  = var.NETBOX_API_TOKEN
}

resource "netbox_site" "home" {
    name      = "Home"
    physical_address  = var.site_location
    status    = "active"
    timezone  = "America/Los_Angeles"
}

/*
*   TENANTS
*/
resource "netbox_tenant" "internal_cosmos" {
    name = "Cosmos"
    description = "internal cosmos network"
}
# resource "netbox_tenant" "internal_dev_k8" {
#     name = "internal_dev_k8"
#     description = "internal development k8 cluster"
#}

/*
*    LOCATIONS
*/
# resource "netbox_location" "test" {
#     name        = "test"
#     description = "my description"
#     site_id     = netbox_site.test.id
#     tenant_id   = netbox_tenant.test.id
# }

resource "netbox_device_role" "odin_role" {
    name      = "Red"
    color_hex = "ff3333"
}

resource "netbox_manufacturer" "odin_manufacturer" {
    name = "GMKtec"
}

resource "netbox_device_type" "odin_device_type" {
    model           = "NucBox M7 Pro"
    manufacturer_id = netbox_manufacturer.odin_manufacturer.id
}

resource "netbox_device" "odin" {
    name           = "Odin"
    device_type_id = netbox_device_type.odin_device_type.id
    role_id        = netbox_device_role.odin_role.id
    site_id        = netbox_site.home.id
    tenant_id      = netbox_tenant.internal_cosmos.id
    # local_context_data = jsonencode({
    #     "setting_a" = "Some Setting"
    #     "setting_b" = 42
    # })
}