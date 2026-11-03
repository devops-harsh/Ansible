output "aws_public_ip" { # used for in loop with : as separation 
  value = [ for instance in aws_instance.spacelift-server : instance.public_ip]
}