/*====
ECR repository to store our Docker images
======*/
resource "aws_ecr_repository" "payment_app" {
  name = "payment/production"
}