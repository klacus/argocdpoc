resource "azuread_group_member" "me" {
  group_object_id  = azuread_group.engineering.object_id
  member_object_id = data.azurerm_client_config.current.object_id
}

resource "azuread_group_member" "me_managers" {
  group_object_id  = azuread_group.engineering_managers.object_id
  member_object_id = data.azurerm_client_config.current.object_id
}

resource "azuread_group_member" "engineering" {
  for_each = { for u in azuread_user.users: u.mail_nickname => u if u.department == "Engineering" }

  group_object_id  = azuread_group.engineering.object_id
  member_object_id = each.value.object_id
}

resource "azuread_group_member" "engineering_managers" {
  for_each = { for u in azuread_user.users: u.mail_nickname => u if u.department == "Engineering" && u.job_title == "Manager" }

  group_object_id  = azuread_group.engineering_managers.object_id
  member_object_id = each.value.object_id
}

resource "azuread_group_member" "system1" {
  for_each = { for u in azuread_user.users: u.mail_nickname => u if u.department == "System1" }

  group_object_id  = azuread_group.system1.object_id
  member_object_id = each.value.object_id
}

resource "azuread_group_member" "system1_managers" {
  for_each = { for u in azuread_user.users: u.mail_nickname => u if u.department == "System1" && u.job_title == "Manager" }

  group_object_id  = azuread_group.system1_managers.object_id
  member_object_id = each.value.object_id
}

resource "azuread_group_member" "system2" {
  for_each = { for u in azuread_user.users: u.mail_nickname => u if u.department == "System2" }

  group_object_id  = azuread_group.system2.object_id
  member_object_id = each.value.object_id
}

resource "azuread_group_member" "system2_managers" {
  for_each = { for u in azuread_user.users: u.mail_nickname => u if u.department == "System2" && u.job_title == "Manager" }

  group_object_id  = azuread_group.system2_managers.object_id
  member_object_id = each.value.object_id
}
