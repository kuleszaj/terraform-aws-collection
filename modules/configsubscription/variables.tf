variable "target_arn" {
  description = <<-EOF
    Target ARN for eventbridge rule.
  EOF
  type        = string
}

variable "name_prefix" {
  type        = string
  description = <<-EOF
    Name prefix for resources.
  EOF
  default     = "observe-config-subscription-"
  nullable    = false
}


