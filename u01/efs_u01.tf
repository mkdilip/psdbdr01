resource "aws_efs_file_system" "u01" {
  creation_token = "u01"

  tags {
  		Name = "u01"
		AppTeam = "PS"
		Ticket = "${var.ticket}"
		CreatedBy = "${var.created_by}"
		RequiredBackup = "No"
		RetentionDays = "0"
       }
}
resource "aws_efs_mount_target" "u01" {
  count = "${var.subnets-count}"
  file_system_id = "${aws_efs_file_system.u01.id}"
  subnet_id      = "${element(var.subnets, count.index)}"
  security_groups = ["${var.sg_efs}"]
}


output "u01_efs_output" {
  value = "${aws_efs_file_system.u01.dns_name}"
}
