variable "instances" {
  description = "A map of instance names to their types"
  type        = map(string)
  
}
variable "ami_id" {
  description = "The ID of the AMI to use for the instances"
  type        = string
  
}