variable "app_name" {
  description = "The name of the application."
  type        = string  
  default     = "argocdpoc"
}

variable "build_repository_uri" {
  description = "The URI of the build repository. This variable is set at runtime by the CI/CD pipeline or local script during development."
  type        = string
}

variable "environment" {
  description = "The environment configuration."
  type = object({
    location       = string
    location_code  = string
    lifecycle = string
    lifecycle_code = string
  })
  default = {
    location       = "eastus2"
    location_code  = "eus2"
    lifecycle      = "proofofconcept"
    lifecycle_code = "poc"
  }
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

variable "aks_config" {
  description = "Configuration for the AKS cluster."
  type = any
}
