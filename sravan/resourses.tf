variable "aws_access_key" {
    default = ""
}

variable "aws_secret_key" {
    default = ""
}

variable "management_ip" {
    default = ""
}

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "us-west-2"
}

resource "aws_instance" "apache" {
  ami           = "ami-7172b611"
  instance_type = "t2.micro"
  security_groups = ["sg-dde4fbba"]
  subnet_id = "subnet-f0f34f94"
  key_name = "suraj_key"
  associate_public_ip_address = true
  
  provisioner "file" {
        source = "chef"
        destination = "/home/ec2-user"
        connection {
            user = "ec2-user"
            key_file = "/home/vamsi/terraform/vamsi/vamsi_key.pem"
            timeout = "60s"
            agent = false
        }
    }

    provisioner "remote-exec" {
        inline = [
                "chmod +x /home/ec2-user/chef/provision.sh",
                "/home/ec2-user/chef/provision.sh app"
        ]
        connection {
            user = "ec2-user"
            key_file = "/home/vamsi/terraform/vamsi/vamsi_key.pem"
            timeout = "60s"
	    agent = false
        }
    }

}
