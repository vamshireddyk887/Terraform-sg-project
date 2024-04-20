variable "security_groups" {
  description = "Map of security groups"
  type        = map(object({
    name_prefix = string
    description = string
    vpc_id      = string
    ingress = object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    })
    egress = object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    })
  }))
  default = {
    "security_group_1" = {
      name_prefix = "Primary"
      description = "Security group 1"
      vpc_id      = "vpc-0e7fe0d01d7646039"
      ingress = {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      egress = {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
    "security_group_2" = {
      name_prefix = "Secondary Security group"
      description = "Security Group 2"
      vpc_id      = "vpc-0e7fe0d01d7646039"
      ingress = {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      egress = {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }
}

variable "net_acls" {
  description = "Map of network ACLs"
  type        = map(object({
    vpc_id  = string
    subnets = map(object({
      ingress_rules  = list(object({
        protocol    = string
        action      = string
        cidr_block  = string
        from_port   = number
        to_port     = number
      }))
      egress_rules   = list(object({
        protocol    = string
        action      = string
        cidr_block  = string
        from_port   = number
        to_port     = number
      }))
    }))
  }))
  default = {
    "primary_network_acl" = {
      vpc_id = "vpc-0e7fe0d01d7646039"  
      subnets = {
        "primary_subnet" = {
          ingress_rules = [
            {
              protocol   = "tcp"
              action     = "allow"
              cidr_block = "0.0.0.0/0"
              from_port  = 1024
              to_port    = 65535
            }
          ]
          egress_rules = [
            {
              protocol   = "tcp"
              action     = "allow"
              cidr_block = "0.0.0.0/0"
              from_port  = 80
              to_port    = 80
            }
          ]
        }
      }
    }

    "network_acl_2" = {
      vpc_id = "vpc-0e7fe0d01d7646039"
      subnets = {
        "example_subnet_2" = {
          ingress_rules = [
            {
              protocol   = "tcp"
              action     = "allow"
              cidr_block = "0.0.0.0/0"
              from_port  = 22
              to_port    = 22
            }
          ]
          egress_rules = [
            {
              protocol   = "tcp"
              action     = "allow"
              cidr_block = "0.0.0.0/0"
              from_port  = 0
              to_port    = 65535
            }
          ]
        }
      }
    }
  }
}