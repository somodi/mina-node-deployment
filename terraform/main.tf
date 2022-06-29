variable "my_access_key" {
  description = "Access-key-for-AWS"
  default = "no_access_key_value_found"
}

variable "my_secret_key" {
  description = "Secret-key-for-AWS"
  default = "no_secret_key_value_found"
}

provider "aws" {
    region = "eu-west-3"
    access_key = var.my_access_key
    secret_key = var.my_secret_key
}

output "ip" {
    value = aws_instance.mina-node.public_ip
}

resource "aws_instance" "mina-node" {
    ami = "ami-058cbbe2ff14ca94d"
    instance_type = "c5.2xlarge"
    key_name = "aws"
    # user_data = "${file("tools/bootstrap_local_env.sh")}"
    # user_data_replace_on_change = true
    tags = {
        Name = "Mina block producer"
    }
    vpc_security_group_ids = [aws_security_group.instance.id]
}

resource "aws_security_group" "instance" {
    name = "mina-node-security-group"
 
    ingress {
        from_port = 8302
        to_port = 8302
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}