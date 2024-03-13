output "ecr_url" {
  value = "${aws_ecr_repository.payment_app.repository_url}"
}