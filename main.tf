provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "app_ami" {
  owners      = ["amazon"]
  most_recent = true


  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10**"]
  }
}
resource "aws_key_pair" "key_pair" {
   key_name   = "masterkey"
 public_key = file("${path.module}/id_ed25519.pub")
}
resource "aws_instance" "golden_image_source" {
  //ami           = "ami-0abcd1234efgh5678" # Base AMI
  ami   =  data.aws_ami.app_ami.id
  instance_type = "t2.micro"
  key_name      = "masterkey"

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd"
    ]
  }

  connection {
  type        = "ssh"
  user        = "ec2-user"
  private_key = file("id_ed25519")
  host        = self.public_ip
}

provisioner "local-exec" {
  command = "echo ${aws_instance.golden_image_source.private_ip} >> private_ips.txt"
}
  tags = {
    Name = "GoldenImageSource"
  }
}

resource "aws_ami_from_instance" "golden_image" {
  source_instance_id = aws_instance.golden_image_source.id
  name               = "golden-image-terraform-ami"
  description        = "AMI built with Terraform"

  lifecycle {
    create_before_destroy = true
  }
}




