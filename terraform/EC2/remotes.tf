### Data sources to get SG

data "terraform_remote_state" "sg" {
  backend = "local"

  config = {
    path = "../SG/terraform.tfstate"
  }
}
