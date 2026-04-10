variable "ami_id" {
  description = "The ID of the AMI to use for the instance"
  type        = string
  
}
variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  
  
}
variable "name" {
  description = "The name tag for the instance"
  type        = string
  
}