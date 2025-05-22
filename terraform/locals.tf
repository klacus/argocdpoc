locals {
  tags = merge(var.tags, {repository = var.build_repository_uri})
}
