resource "aws_lambda_function" "this" {
  function_name = var.name
  role          = var.role
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  filename      = var.file
}