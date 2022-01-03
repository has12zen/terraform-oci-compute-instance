data "template_file" "server_template" {
  template = file("${path.module}/scripts/setup.sh")
  vars = {
    password = "hello script"
  }
}

data "template_file" "server_cloud_init_file" {
  template = file("${path.module}/cloud-init/cloud-init.template.yaml")
  vars = {
    bootstrap_sh_content = base64gzip(data.template_file.server_template.rendered)
  }

}

data "template_cloudinit_config" "server" {
  gzip          = true
  base64_encode = true
  part {
    filename     = "server.yaml"
    content_type = "text/cloud-config"
    content      = data.template_file.server_cloud_init_file.rendered
  }
}
