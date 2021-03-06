data "aws_ip_ranges" "useast_ec2" {
    regions = [ "us-east-1" ]
    services = [ "ec2" ]
}

variable "max_egress_rules" {
    default = 60
}

locals {
    chunks = chunklist(data.aws_ip_ranges.useast_ec2.cidr_blocks, var.max_egress_rules)
    chunks_map = { for i in range(length(local.chunks)): i => local.chunks[i] }
}

resource "aws_security_group" "sg" {
    for_each = local.chunks_map

    name = "from_us_${each.key}"

    egress {
      cidr_blocks = each.value
      from_port = 443
      protocol = "tcp"
      to_port = 443
    }
    tags = {
      CreateDate = data.aws_ip_ranges.useast_ec2.create_date
      SyncToken  = data.aws_ip_ranges.useast_ec2.sync_token
    }
}
### Outdate code ###
#resource "aws_security_group" "from_us" {
    #name = "from_us"

        #ingress {
            #from_port   = "443"
            #to_port     = "443"
            #protocol    = "tcp"
            #cidr_blocks = data.aws_ip_ranges.useast_ec2.cidr_blocks
#        }
        #tags = {
            #CreateDate = data.aws_ip_ranges.useast_ec2.create_date
            #SyncToken  = data.aws_ip_ranges.useast_ec2.sync_token
#        }
#}