variable "region" {
  default = "us-west-2"
  }

variable "subnets-count" {
  default = "3"
}

variable "subnets" {
  default = ["subnet-0267c8fd1c45b2204","subnet-0c8350352f4ec2bd1","subnet-02230cbf2a332ec48"]
}

variable "sg_efs" {
  default = "sg-0e0a3ef42727aa1db"
}

variable "ticket" {
   default = "CLOUD-65"
}

variable "created_by" {
   default = "dilipk"
}
