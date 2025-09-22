provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Admin-Environment = var.env
      Admin-ServiceDomain = var.service_domain
      Team = var.team
    }
  }  
}