variable "greeting_name" {
  type        = string
  default     = "default"
  description = "Greeting name injected as GREETING_NAME (per environment)."
}

variable "replica_count" {
  type        = number
  default     = 2
  description = "Deployment replica count (per environment)."
}

variable "kubeconfig_path" {
  type        = string
  default     = "~/.kube/config"
  description = "Kubeconfig used by the Helm provider. Point this at the k3d cluster, not Docker Desktop."
}
