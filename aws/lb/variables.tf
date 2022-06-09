variable "lb" {
  description = "A map of objects that contain the variables for LBs in AWS."
  default = null
  type = list(object({
    name = string,
    internal = bool,
    load_balancer_type = string,
    security_groups = list(string),
    subnets = list(string),
    enable_deletion_protection = bool,
    access_logs = object({
      bucket = string,
      prefix = string,
      enabled = bool
    }),
  }))
}
