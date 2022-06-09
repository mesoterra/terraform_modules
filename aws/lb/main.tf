#output "debug" {
#  value = aws_lb.lb
#}

resource "aws_lb" "lb" {
  for_each = {for balancer in var.lb: balancer.name => balancer}

  name = each.value.name
  internal = each.value.internal
  load_balancer_type = each.value.load_balancer_type
  security_groups =  each.value.load_balancer_type != "application" ? null : each.value.security_groups
  subnets = each.value.subnets
  enable_deletion_protection = each.value.enable_deletion_protection
  access_logs {
    bucket = each.value.access_logs.bucket
    prefix = each.value.access_logs.prefix
    enabled = each.value.access_logs.enabled
  }
}
