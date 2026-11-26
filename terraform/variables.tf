variable "seed" {
  description = "Sum of the last four digits of your student ID"
  type        = number
}

variable "instances" {
  description = "Number of web containers"
  type        = number
  default     = 2
}

variable "base_port" {
  description = "Host ports start here, plus your seed"
  type        = number
  default     = 8500
}
