output "output_sqs_url" {
  value = "${aws_sqs_queue.payment_queue_processed.url}"
}