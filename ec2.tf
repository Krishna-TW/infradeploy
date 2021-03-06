resource "aws_instance" "web" {
  ami           = "ami-00f7e5c52c0f43726"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-0785ae796b2761b5a"]
  key_name = "Krish"
  
  connection {
    host        = "${self.public_ip}"
    user        = "ec2-user"
    type        = "ssh"
    private_key = "${file("/home/ec2-user/Krish")}"
  }

   provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ec2-user/Krish",
      "sudo amazon-linux-extras install java-openjdk11 -y",
      "sudo yum install java-1.8.0-openjdk -y",
    ]
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} ansible_ssh_user=ec2-user ansible_ssh_private_key_file=/root/Krish > /etc/ansible/hosts"
  }
  

  tags = {
    Name = "HelloWorld"
  }
}
