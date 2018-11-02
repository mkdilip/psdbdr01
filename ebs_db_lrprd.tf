resource "aws_ebs_volume" "db_lrprd" {
    availability_zone = "us-west-2a"
    size = 15
    type = "gp2"
    tags {
		Name	= "psdbdr01.db_lrprd"
                Requiredbackup = "No"
                RetentionDays = "0"
		AppTeam	= "${var.practise_area}"
		Application = "${var.app_name}"
		Environment = "${var.env_name}"
		Ticket = "${var.ticket}"
		RiskType = "${var.risk_type}"
		CreatedBy = "${var.created_by}"
	}
}	

output "db_lrprd_volume_output" {
  value = "${aws_ebs_volume.db_lrprd.id}"
}
