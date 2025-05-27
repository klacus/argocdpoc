variable "build_repository_uri" {
  description = "The URI of the build repository. This variable is set at runtime by the CI/CD pipeline or local script during development."
  type        = string
}

variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
}

variable "tags" {
  description = "Tags to be applied to all resources."
  type        = map(string)
  default     = {
    project     = "argo-cd-poc"
    provisioner = "terraform"
    purpose     = "Proof of concept for Argo CD."
  }
}
