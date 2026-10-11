variable "access_context_manager_access_levels" {
  description = <<EOT
Map of access_context_manager_access_levels, attributes below
Required:
    - parent
Optional:
    - deletion_policy
    - access_levels (block):
        - basic (optional, block):
            - combining_function (optional)
            - conditions (required, block):
                - device_policy (optional, block):
                    - allowed_device_management_levels (optional)
                    - allowed_encryption_statuses (optional)
                    - os_constraints (optional, block):
                        - minimum_version (optional)
                        - os_type (required)
                    - require_admin_approval (optional)
                    - require_corp_owned (optional)
                    - require_screen_lock (optional)
                - ip_subnetworks (optional)
                - members (optional)
                - negate (optional)
                - regions (optional)
                - required_access_levels (optional)
                - vpc_network_sources (optional, block):
                    - vpc_subnetwork (optional, block):
                        - network (required)
                        - vpc_ip_subnetworks (optional)
        - custom (optional, block):
            - expr (required, block):
                - description (optional)
                - expression (required)
                - location (optional)
                - title (optional)
        - description (optional)
        - name (required)
        - title (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    parent          = string
    deletion_policy = optional(string)
    access_levels = optional(list(object({
      basic = optional(object({
        combining_function = optional(string)
        conditions = list(object({
          device_policy = optional(object({
            allowed_device_management_levels = optional(list(string))
            allowed_encryption_statuses      = optional(list(string))
            os_constraints = optional(list(object({
              minimum_version = optional(string)
              os_type         = string
            })))
            require_admin_approval = optional(bool)
            require_corp_owned     = optional(bool)
            require_screen_lock    = optional(bool)
          }))
          ip_subnetworks         = optional(list(string))
          members                = optional(list(string))
          negate                 = optional(bool)
          regions                = optional(list(string))
          required_access_levels = optional(list(string))
          vpc_network_sources = optional(list(object({
            vpc_subnetwork = optional(object({
              network            = string
              vpc_ip_subnetworks = optional(list(string))
            }))
          })))
        }))
      }))
      custom = optional(object({
        expr = object({
          description = optional(string)
          expression  = string
          location    = optional(string)
          title       = optional(string)
        })
      }))
      description = optional(string)
      name        = string
      title       = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.access_context_manager_access_levels : (
        v.access_levels == null || alltrue([for item in v.access_levels : (item.basic == null || (length(item.basic.conditions) >= 1))])
      )
    ])
    error_message = "Each conditions list must contain at least 1 items"
  }
  # Note: 4 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

