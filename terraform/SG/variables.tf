### Global variables

variable "region" {
  type = string
}

variable "organization_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "project" {
  type = string
}



### Resource variables

variable "ingress_port_list" {
  type = list(object({
    from_port = number
    to_port   = number
  }))
}

variable "cidr_blocks" {
  type = string
}
