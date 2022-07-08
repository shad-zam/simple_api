terraform {
  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "shad_zam"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "simple_api_gh_actions"
    }
  }

  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.63"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

# al2022-ami-2022.0.20220531.0-kernel-5.15-x86_64