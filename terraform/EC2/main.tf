### Get Availability Zone from default VPC

resource "aws_default_subnet" "default_az4" {
  availability_zone = "us-east-1a"
}

### Get data from Key Pair
data "aws_key_pair" "keypair_test" {
  key_name = "${lower(var.project)}-${lower(var.environment)}-kp"
}


### EC2 Instance

resource "aws_instance" "instance_test" {
  ami                     = var.ami
  instance_type           = var.instance_type
  subnet_id               = aws_default_subnet.default_az4.id
  key_name                = data.aws_key_pair.keypair_test.key_name
  vpc_security_group_ids  = [data.terraform_remote_state.sg.outputs.sg_ec2_id]
  disable_api_stop        = true
  disable_api_termination = true
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 20
    volume_type           = "gp3"
  }


  tags = {
    Name         = "${lower(var.project)}-${lower(var.environment)}-ec2"
    Organization = "${lower(var.organization_name)}"
    Environment  = "${lower(var.environment)}"
    Project      = "${lower(var.project)}"
    ManagedBy    = "terraform"
  }
}
