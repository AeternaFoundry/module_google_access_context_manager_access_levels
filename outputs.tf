output "access_context_manager_access_levels_id" {
  description = "Map of id values across all access_context_manager_access_levels, keyed the same as var.access_context_manager_access_levels except keys with no id are omitted"
  value       = { for k, v in google_access_context_manager_access_levels.access_context_manager_access_levels : k => v.id if v.id != null && length(v.id) > 0 }
}
output "access_context_manager_access_levels_access_levels" {
  description = "Map of access_levels values across all access_context_manager_access_levels, keyed the same as var.access_context_manager_access_levels except keys with no access_levels are omitted"
  value       = { for k, v in google_access_context_manager_access_levels.access_context_manager_access_levels : k => v.access_levels if v.access_levels != null && length(v.access_levels) > 0 }
}
output "access_context_manager_access_levels_deletion_policy" {
  description = "Map of deletion_policy values across all access_context_manager_access_levels, keyed the same as var.access_context_manager_access_levels except keys with no deletion_policy are omitted"
  value       = { for k, v in google_access_context_manager_access_levels.access_context_manager_access_levels : k => v.deletion_policy if v.deletion_policy != null && length(v.deletion_policy) > 0 }
}
output "access_context_manager_access_levels_parent" {
  description = "Map of parent values across all access_context_manager_access_levels, keyed the same as var.access_context_manager_access_levels except keys with no parent are omitted"
  value       = { for k, v in google_access_context_manager_access_levels.access_context_manager_access_levels : k => v.parent if v.parent != null && length(v.parent) > 0 }
}

