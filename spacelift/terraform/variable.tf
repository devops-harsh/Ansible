variable "instances_type" {
  type = string
  default = "t2.micro"
}

variable "public_key" {
  type    = string
  default = "/mnt/workspace/id_rsa.pub"
}