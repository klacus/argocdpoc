# resource "random_pet" "suffix" {
#   length = 2
# }

resource "azuread_user" "users" {
  for_each = { for user in local.users : user.first_name => user }

  user_principal_name = format(
    "%s%s@%s",
    substr(lower(each.value.last_name), 0 , 1),
    lower(each.value.first_name),
    # random_pet.suffix.id,
    local.domain_name
  )

  password = format(
    "%s%s%s%s!",
    lower(each.value.last_name),
    substr(lower(each.value.first_name), 0 , 1),
    length(each.value.first_name),
    "thisis1POC"
  )
  force_password_change = true

  display_name = "${each.value.first_name} ${each.value.last_name}"

  department   = each.value.department
  job_title    = each.value.job_title
}

resource "azuread_group" "engineering" {
  display_name = "Engineering Department"
  security_enabled = true
}


resource "azuread_group" "engineering_managers" {
  display_name = "Engineering - Managers"
  security_enabled = true
}

resource "azuread_group" "system1" {
  display_name = "System1 Developers"
  security_enabled = true
}

resource "azuread_group" "system1_managers" {
  display_name = "System1 - Managers"
  security_enabled = true
}

resource "azuread_group" "system2" {
  display_name = "System2 Developers"
  security_enabled = true
}

resource "azuread_group" "system2_managers" {
  display_name = "System2 - Managers"
  security_enabled = true
}
