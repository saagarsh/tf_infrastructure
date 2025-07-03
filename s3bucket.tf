# S3 bucket created on AWS with the help of terraform using resource block

 resource "aws_s3_bucket" "mybucket"{
     bucket = "this-is-my-terraform-bucket"

     tags = {
         name = "whatshouldicallit"
         environment = "dev"
}
}
