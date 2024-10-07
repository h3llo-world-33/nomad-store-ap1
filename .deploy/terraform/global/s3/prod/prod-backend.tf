terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-2"
}

module "backend_config" {
  source = "../../../modules/backends/s3"

  bucket_name = "nomad-prod-state-buck3t"
  dynamodb_name = "nomad-prod-table-locks"
}

terraform {
  backend "s3" {
    # set bucket details
    bucket = "nomad-prod-state-buck3t"
    key = "global/s3/prod/terraform.tfstate"
    region = "us-east-2"

    # dynamo db table details for locking
    dynamodb_table = "nomad-prod-table-locks"
    encrypt = true
  }
}