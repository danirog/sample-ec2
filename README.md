# sample-ec2

## Terraform

### Prerequisites

- Create a Key Pair for EC2 instance.
- You must create a `terraform.tfvars` file in each plan to add values ​​to variables.

#### Example of terraform.tfvars file for the SG plan

```
region            = "us-east-1"
organization_name = "company"
environment       = "test"
project           = "unknown"
ingress_port_list = [
  {
    from_port = 22,
    to_port   = 22
  },
  {
    from_port = 80,
    to_port   = 80
  }
]
cidr_blocks = "0.0.0.0/0"
```

#### Example of terraform.tfvars file for the EC2 plan

```
region            = "us-east-1"
organization_name = "company"
environment       = "test"
project           = "unknown"
ami           = "ami-064519b8c76274859" # debian 12
instance_type = "t3.small"

```

### Deploy Infraestructure

Before to deploy, you must set the following environment variables for Terraform can login into AWS:

```
export AWS_ACCESS_KEY_ID=xxxxxxxxxx
```

```
export AWS_SECRET_ACCESS_KEY=xxxxxxxxxx
```

```
export REGION=xxxxxxxxxx
```

Then, you can deploy infrastructure:

```
terraform init
terraform validate
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

Or if you want destroy infrastructure:

```
terraform destroy -var-file=terraform.tfvars
```

### Order to deploy terraform plans

- SG
- EC2 (First, you must create a Key Pair)
