variable "region" {
  default = "us-west-2"
  }

variable "asg_name" {
  default = "APEXDEV3_DB_psdbdr01"
}

variable "lc_prefix" {
  default = "APEXDEV3_DB_psdbdr01"
}

variable "VPC" {
  default = "vpc-0c5b098d775a88960"
}

variable "subnets-count" {
  default = "3"
}

variable "iamrole" {
  default = "ps_ec2"
}

variable "subnet1" {
  default = "subnet-0267c8fd1c45b2204"
}
variable "zoneA" {
  default = "subnet-0267c8fd1c45b2204" 
}

variable "subnet2" {
  default = "subnet-0c8350352f4ec2bd1" 
}
variable "zoneB" {
  default = "subnet-0c8350352f4ec2bd1"
}

variable "subnet3" {
  default = "subnet-02230cbf2a332ec48"
}
variable "zoneC" {
  default = "subnet-02230cbf2a332ec48"
}

variable "subnetmain" {
  default = "subnet-0267c8fd1c45b2204"
}
variable "zonemain" {
  default = "subnet-0267c8fd1c45b2204"
}

variable "subnets" {
  default = ["subnet-0267c8fd1c45b2204","subnet-0c8350352f4ec2bd1","subnet-02230cbf2a332ec48"]
}
variable "min_size" {
  default = "1"
}

variable "max_size" {
  default = "1"
}

variable "asg_desired" {
  default = "1"
}

variable "health_check_grace_period" {
  default = "300"
}


variable "packer_ami" {
  default = "ami-0323e6a4b5d273f7d"
}

variable "instance_type" {
  default = "t2.large"
}

variable "key_name" {
  default = "ec2keypair"
}


variable "host_name" {
  default = "psdbdr01"
  }

#variable "local_domain_name" {
#  default = "erpdr.stanford.edu"
#  }

variable "external_domain_name" {
  default = "erpdr.stanford.edu"
  }

variable "delete_on_termination" {
  default = "true"
}

variable "nfs_share_volume" {
  default = "fs-96941f3f.efs.us-west-2.amazonaws.com:/"
}

variable "rundir" {
  default = "/scripts"
}

variable "sg_efs" {
  default = "sg-0e0a3ef42727aa1db"
}

variable "sgAsia" {
  default = "sg-0e0a3ef42727aa1db"
}

variable "sgApp" {
  default = "sgext"
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = "20"
}

variable "swap_dev_name" {
  default = "/dev/xvdf"
}
variable "swap_vol_size" {
  default = "10"
}

variable "route53_zone_id" {
  default = "Z3LNW16S2I1HHW"
}

variable "efs_dns_name" {
   default = "efsdnsname"
}

variable "practise_area" {
   default = "PS"
}

variable "app_name" {
   default = "Apex"
}

variable "env_name" {
   default = "APEXDEV3"
}

variable "ticket" {
   default = "CLOUD-65"
}

variable "risk_type" {
   default = "LOW"
}

variable "created_by" {
   default = "dilipk"
}

variable "s3_sys_bucket" {
   default = "userdata-sysadmin.stanford.edu"
}

variable "s3_app_location" {
    default = "s3://userdata-ps.stanford.edu/aws_ec2_create/psdbdr01"
}
