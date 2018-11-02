resource "aws_efs_file_system" "app" {
  creation_token = "app"

  tags {
  		Name = "app"
		AppTeam = "PS"
		Ticket = "${var.ticket}"
		CreatedBy = "${var.created_by}"
		RequiredBackup = "No"
		RetentionDays = "0"
       }
}
resource "aws_efs_mount_target" "app" {
  count = "${var.subnets-count}"
  file_system_id = "${aws_efs_file_system.app.id}"
  subnet_id      = "${element(var.subnets, count.index)}"
  security_groups = ["${var.sg_efs}"]
}


output "app_efs_output" {
  value = "${aws_efs_file_system.app.dns_name}"
}
