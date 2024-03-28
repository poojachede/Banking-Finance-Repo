resource "aws_instance" "Test-Server" {
  ami           = "ami-080e1f13689e07408" 
  instance_type = "t2.micro" 
  key_name = "poojakey"
  vpc_security_group_ids= ["sg-0481160cc96026b15"]
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./poojakey.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "Test-Server"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.Test-Server.public_ip} > inventory"
  }
  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/Banking-Finance-Project/terraform-files/ansiblefile.yml"
  }
  }
