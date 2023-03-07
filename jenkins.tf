module "jenkins_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "Jenkins-SG"
  description = "Security group for jenkins instance"
  vpc_id      = "vpc-04f443848938d7b0c"
  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["http-80-tcp"]
  egress_rules		   = ["all-all"]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "jenkins-server"
  ami                    = "ami-006dcf34c09e50022"
  instance_type          = "t3.micro"
  key_name               = "vockey"
  monitoring             = true
  vpc_security_group_ids = [module.jenkins_sg.security_group_id]
  subnet_id              = "subnet-01e60694d044a75a4"
  user_data              = file("./dependencias.sh")
  iam_instance_profile   = "LabInstanceProfile"

  tags = {
    Name   = "Jenkins-Server"
    Environment = "Prod"
  }
}

resource "aws_eip" "jenkins-ip" {
  instance = module.ec2_instance.id
  vpc      = true
}
