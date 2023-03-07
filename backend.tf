terraform {
  backend "s3" {
    bucket = "vcavalcanti-vorx-terraform"
    key    = "jenkins-server.tfstate"
    region = "us-east-1"
  }
}
