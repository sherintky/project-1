provider "aws" {
  region = "us-east-1"
}

locals {
  default_name = "${join("-", list(terraform.workspace, "example"))}"
}

resource "aws_instance" "example2" {
  tags = {
    Name = local.default_name
  }

  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = lookup(var.instance_type,terraform.workspace)
  key_name      =  var.key_name
  vpc_security_group_ids = [var.sg_id]
  
  connection { 
       user = "ec2-user"
       type = "ssh"
       private_key = file(var.pvt_key)
       host = self.public_ip
  }

  provisioner "file" {
    source = "./frontend"
    destination = "~/"
  }
  
  
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x ~/frontend/run_frontend.sh",
      "cd  ~/frontend", 
      "sudo  ~/frontend/run_frontend.sh",
    ]

  }
  
  provisioner "local-exec" {
    command = "echo ${aws_instance.example2.private_ip} >> /tmp/private_ips.txt"
 }

}
  resource "null_resource" "ansible-main" {
  provisioner "local-exec" {
    command = "ansible-playbook -e sshKey=${var.pvt_key} -i '${aws_instance.example2.public_ip},' ./ansible/setup-backend.yaml -v"
  }
   depends_on = [ aws_instance.example2 ]
  }
