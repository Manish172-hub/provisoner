# provisoner
Using Provisoner create public IP and private Ip  and using jenkins create Ansible 

1.Creat the terraform code in local 
2.Update the public and private key path (create key on jenkins server and same put over here) 
3.Install Jenkins on server (Prerequiste java 17 install jenkins repo added rpm Key added install jenkins configure jenkins change jenkins user shell from /bin/false to /bin/bash #usermod -s /bin/bash jenkins set passwd for jenkins user. change passwd authentication settings in /etc/ssh/sshd_config and restar sshd. ) 
4.Install git on server 
5.Install Terraform on server 
6.Login into jenkin user (su - jenkins)
7. create ssh key using command sshkeygen 
8.create .ssh (pub_key,private_key,etc). 
9.Pass tthe same usey to terraform public and private key
