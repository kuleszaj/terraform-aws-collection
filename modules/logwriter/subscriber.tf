module "subscriber" {
  count  = local.enable_subscription ? 1 : 0
  source = "../subscriber"

  name                    = var.name
  filter_name             = var.filter_name
  filter_pattern          = var.filter_pattern
  log_group_name_patterns = var.log_group_name_patterns
  log_group_name_prefixes = var.log_group_name_prefixes
  discovery_rate          = var.discovery_rate
  num_workers             = var.num_workers
  destination_iam_arn     = aws_iam_role.destination.arn
  firehose_arn            = aws_kinesis_firehose_delivery_stream.delivery_stream.arn
  lambda_env_vars         = var.lambda_env_vars
  lambda_memory_size      = var.lambda_memory_size
  lambda_timeout          = var.lambda_timeout
}