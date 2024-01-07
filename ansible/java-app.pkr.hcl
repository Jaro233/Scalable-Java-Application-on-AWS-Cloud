locals {
    app_name = "petclinic-3.1.0"
}

source "amazon-ebs" "java-app" {
  ami_name      = "PACKER-${local.app_name}"
  instance_type = "t2.medium"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"] # Canonical
  }
  ssh_username = "ubuntu"

  // Specify the path to your SSH private key file
  #ssh_private_key_file = "./ec2_apache.pem"

  // Add your SSH public key to the instance
  #ssh_keypair_name = "ec2_apache"
  #ssh_interface    = "public_ip"
  #ssh_agent_auth = true

  tags = {
    Env  = "DEMO"
    Name = "PACKER-${local.app_name}"
  }
}

build {
  sources = [
    "source.amazon-ebs.java-app"
  ]

  provisioner "ansible" {
    playbook_file = "./java-app.yml"
  }
}
