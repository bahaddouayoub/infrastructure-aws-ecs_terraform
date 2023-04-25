variable "name" {
  type        = string
  description = "The name of the cluster"
}

variable "cluster_tag_name" {
  type        = string
  description = "Name tag for the cluster"
}

variable "namespace" {
  type = string
  description = "namespace used by service connect"
}