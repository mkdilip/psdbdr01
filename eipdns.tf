resource "aws_eip" "psdbdr01" {
  vpc      = true
    tags {
		Name	= "psdbdr01"
		AppTeam	= "${var.practise_area}"
		Application = "${var.app_name}"
		Environment = "${var.env_name}"
		Ticket = "${var.ticket}"
		RiskType = "${var.risk_type}"
		CreatedBy = "${var.created_by}"
	}
  lifecycle {
    prevent_destroy = false
  }
}

output "psdbdr01_output" {
   value = "${aws_eip.psdbdr01.id}"
}

output "psdbdr01_iaddr_output" {
  value = "${aws_eip.psdbdr01.public_ip}"
}



resource "aws_route53_record" "psdbdr01" {
  zone_id = "${var.route53_zone_id}"
  name    = "psdbdr01.erpdr.stanford.edu"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.psdbdr01.public_ip}"]
}
