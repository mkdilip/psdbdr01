resource "aws_ebs_volume" "asm1" {
    availability_zone = "us-west-2a"
    size = 20
    type = "gp2"
    tags {
		Name	= "psdbdr01.asm1"
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

output "asm1_volume_output" {
  value = "${aws_ebs_volume.asm1.id}"
}
