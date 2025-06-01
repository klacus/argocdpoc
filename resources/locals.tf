locals {
  domain_name = data.azuread_domains.default.domains.0.domain_name
  users       = csvdecode(file("${path.module}/../users.csv"))
  tags        = merge(var.tags, { repository = var.build_repository_uri })
}
