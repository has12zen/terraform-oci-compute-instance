resource "oci_core_instance" "ubuntu_instance" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = ""
  shape               = "VM.Standard.E2.1.Micro"
  source_details {
    source_id   = "ocid1.image.oc1.eu-zurich-1.aaaaaaaarge5cqqk3rnnnmzi2qn3pampycrsvrnpxin7rg6nkslkupzqvv6a"
    source_type = "image"
  }

  # Optional
  display_name = "terrabuntu"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = ""
  }
  metadata = {
    ssh_authorized_keys = file("~/.ssh/id_rsa.pub")
    user_data           = data.template_cloudinit_config.server.rendered

  }
  preserve_boot_volume = false
}
