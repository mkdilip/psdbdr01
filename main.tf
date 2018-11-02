provider "aws" {
  region = "${var.region}"
}

resource "aws_autoscaling_group" "APEXDEV3_DB_psdbdr01" {
  name		            = "${var.asg_name}"
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  desired_capacity          = "${var.asg_desired}"
  health_check_grace_period = "${var.health_check_grace_period}"
  vpc_zone_identifier       = ["${var.subnetmain}"]
  launch_configuration      = "${aws_launch_configuration.APEXDEV3_DB_psdbdr01.name}"
  tag {
    key = "ASGName"
    value = "${var.asg_name}"
    propagate_at_launch = true    
  }
  tag {
    key = "Name"
    value = "${var.host_name}"
    propagate_at_launch = true    
  }
  lifecycle {
    create_before_destroy = true
    }
}

resource "aws_launch_configuration" "APEXDEV3_DB_psdbdr01" {
  name_prefix                 = "${var.lc_prefix}"
  image_id                    = "${var.packer_ami}" 
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${var.sgAsia}","sg-0358741766a29fa6f","sg-00edde07fc7bb8e3d"]
  iam_instance_profile        = "${var.iamrole}"
  associate_public_ip_address = true
  user_data = "${data.template_file.userdata.rendered}"

  root_block_device {
    volume_type           = "${var.volume_type}"
    volume_size           = "${var.volume_size}"
    delete_on_termination = "${var.delete_on_termination}"
  }
# Swap filesystem
  ebs_block_device {
    device_name = "${var.swap_dev_name}"
    volume_size = "${var.swap_vol_size}"
    volume_type = "${var.volume_type}"
    delete_on_termination = "${var.delete_on_termination}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.sh")}"
  vars {
    host_name = "${var.host_name}"
    rundir = "${var.rundir}"
    s3_sys_bucket = "${var.s3_sys_bucket}"
    s3_app_location = "${var.s3_app_location}"
    my_eip_id = "${aws_eip.psdbdr01.id}"
app_vol = "fs-4a56a4e2.efs.us-west-2.amazonaws.com"
u01_vol = "fs-1c57a5b4.efs.us-west-2.amazonaws.com"
asm1_vol = "${aws_ebs_volume.asm1.id}"
db_lrprd_vol = "${aws_ebs_volume.db_lrprd.id}"
backup_vol = "${aws_ebs_volume.backup.id}"
u02_vol = "vol-0142e3569c2c18f46"
}
}
