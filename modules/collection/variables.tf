variable "name" {
  type        = string
  description = <<-EOF
    Name of role. Since this name must be unique within the
    account, it will be reused for most of the resources created by this
    module.
  EOF

  validation {
    condition     = length(var.name) <= 50
    error_message = "Name must be at most 50 characters long."
  }
}

variable "destination" {
  type = object({
    arn    = string
    bucket = string
    prefix = string
  })
  nullable    = false
  description = "Destination filedrop"
}

variable "forwarder" {
  description = <<-EOF
    Variables for forwarder module.
  EOF
  type = object({
    source_bucket_names                      = optional(list(string), [])
    source_topic_arns                        = optional(list(string), [])
    content_type_overrides                   = optional(list(object({ pattern = string, content_type = string })), [])
    max_file_size                            = optional(number)
    lambda_memory_size                       = optional(number)
    lambda_timeout                           = optional(number)
    lambda_env_vars                          = optional(map(string))
    retention_in_days                        = optional(number)
    queue_max_receive_count                  = optional(number)
    queue_delay_seconds                      = optional(number)
    queue_message_retention_seconds          = optional(number)
    queue_batch_size                         = optional(number)
    queue_maximum_batching_window_in_seconds = optional(number)
  })
  default  = {}
  nullable = false
}

variable "config" {
  description = <<-EOF
    Variables for AWS Config collection.
  EOF
  type = object({
    include_resource_types        = list(string)
    exclude_resource_types        = optional(list(string))
    delivery_frequency            = optional(string)
    include_global_resource_types = optional(bool)
  })
  default = null
}

variable "logwriter" {
  description = <<-EOF
    Variables for AWS CloudWatch Logs collection.
  EOF
  type = object({
    log_group_name_patterns = optional(list(string))
    log_group_name_prefixes = optional(list(string))
    buffering_interval      = optional(number)
    buffering_size          = optional(number)
    filter_name             = optional(string)
    filter_pattern          = optional(string)
    num_workers             = optional(number)
    discovery_rate          = optional(string, "24 hours")
    lambda_memory_size      = optional(number)
    lambda_timeout          = optional(number)
  })
  default = null
}

variable "metricstream" {
  description = <<-EOF
    Variables for AWS CloudWatch Metrics Stream collection.
  EOF
  type = object({
    include_filters    = optional(list(object({ namespace = string, metric_names = optional(list(string)) })))
    exclude_filters    = optional(list(object({ namespace = string, metric_names = optional(list(string)) })))
    buffering_interval = optional(number)
    buffering_size     = optional(number)
  })
  default = null
}