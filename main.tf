resource "google_access_context_manager_access_levels" "access_context_manager_access_levels" {
  for_each = var.access_context_manager_access_levels

  parent          = each.value.parent
  deletion_policy = each.value.deletion_policy

  dynamic "access_levels" {
    for_each = each.value.access_levels != null ? each.value.access_levels : []
    content {
      dynamic "basic" {
        for_each = access_levels.value.basic != null ? [access_levels.value.basic] : []
        content {
          combining_function = basic.value.combining_function
          dynamic "conditions" {
            for_each = basic.value.conditions
            content {
              dynamic "device_policy" {
                for_each = conditions.value.device_policy != null ? [conditions.value.device_policy] : []
                content {
                  allowed_device_management_levels = device_policy.value.allowed_device_management_levels
                  allowed_encryption_statuses      = device_policy.value.allowed_encryption_statuses
                  dynamic "os_constraints" {
                    for_each = device_policy.value.os_constraints != null ? device_policy.value.os_constraints : []
                    content {
                      minimum_version = os_constraints.value.minimum_version
                      os_type         = os_constraints.value.os_type
                    }
                  }
                  require_admin_approval = device_policy.value.require_admin_approval
                  require_corp_owned     = device_policy.value.require_corp_owned
                  require_screen_lock    = device_policy.value.require_screen_lock
                }
              }
              ip_subnetworks         = conditions.value.ip_subnetworks
              members                = conditions.value.members
              negate                 = conditions.value.negate
              regions                = conditions.value.regions
              required_access_levels = conditions.value.required_access_levels
              dynamic "vpc_network_sources" {
                for_each = conditions.value.vpc_network_sources != null ? conditions.value.vpc_network_sources : []
                content {
                  dynamic "vpc_subnetwork" {
                    for_each = vpc_network_sources.value.vpc_subnetwork != null ? [vpc_network_sources.value.vpc_subnetwork] : []
                    content {
                      network            = vpc_subnetwork.value.network
                      vpc_ip_subnetworks = vpc_subnetwork.value.vpc_ip_subnetworks
                    }
                  }
                }
              }
            }
          }
        }
      }
      dynamic "custom" {
        for_each = access_levels.value.custom != null ? [access_levels.value.custom] : []
        content {
          expr {
            description = custom.value.expr.description
            expression  = custom.value.expr.expression
            location    = custom.value.expr.location
            title       = custom.value.expr.title
          }
        }
      }
      description = access_levels.value.description
      name        = access_levels.value.name
      title       = access_levels.value.title
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

