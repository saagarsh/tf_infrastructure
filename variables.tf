variable "ec2_instance_type" {
  default = "t3.micro"
}

variable "ec2_storage_size" {
  default = 9
}

variable "ec2_ami_id" {
  default = "ami-042b4708b1d05f512"
}

variable "env" {
    default = "dev"
}