variable "app_name" {
  description = "The name of the application."
  type        = string  
  default     = "argocdpoc"
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
    lifecycle      = "development"
    lifecycle_code = "dev"
  }
} 

variable "tags" {
  description = "Tags to be applied to all resources."
  type        = map(string)
  default     = {
    owner       = "devops-team"
    project     = "argo-cd-poc"
    provisioner = "terraform"   
  }
}

variable "build_repository_uri" {
  description = "The URI of the build repository. This variable is set at runtime by the CI/CD pipeline."
  type        = string
}

variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
}