 1538  mkdir 21-Ansible
 1540  cd 21-Ansible/
 1542  apt-get install ansible -y 
 1544* ansible --ver
 1552  ansible 172.31.0.100 -i inventory -u vagrant -m ping -k 
 1558  ansible 172.31.0.100 -i inventory -u vagrant -m ping -k 
 1560  ansible 172.31.0.101 -i inventory -u vagrant -m ping -k 
 1561  cat /etc/ansible/ansible.cfg 
 1562  grep -i host_key_checking  /etc/ansible/ansible.cfg 
 1564  vim ansible.cfg 
 1566  ansible 172.31.0.101 -i inventory -u vagrant -m ping -k 
 1567  ansible all -i inventory -u vagrant -m ping -k 
 1569  ansible all -i inventory -u vagrant -m ping -k 
 1570  ansible web -i inventory -u vagrant -m ping -k 
 1571  ansible db -i inventory -u vagrant -m ping -k 
 1574  ansible prod -i inventory -m ping  
 1575  ansible-doc  -l 
 1576  ansible-doc  apt 
 1578  ansible prod -i inventory -m apt -a "name=net-tools state=present"  
 1579  ansible prod -i inventory -m apt -a "name=net-tools state=present"  -s 
 1581  ansible prod -i inventory -m apt -a "name=net-tools state=absent"  -s 
 1587  history | grep -i ansible 
 1588  history | grep -i ansible
 1589  history | grep -i ansible > README.md
 1595  git add . ; git commit -m "21-Ansible"; git push 
 1618  cd 21-Ansible/
 1624  cat ansible.cfg 
 1633  ansible-playbook -i inventory backend-playbook.yaml 
 1637  ansible-playbook -i inventory backend-playbook.yaml 
 1640  ansible-playbook -i inventory backend-playbook.yaml 
 1652  ansible-playbook -i inventory backend-playbook.yaml 
 1656  ansible 172.31.0.100 -i inventory -m setup 
 1659  ansible-playbook -i inventory backend-playbook.yaml 
 1663  ansible-playbook -i inventory backend-playbook.yaml 
 1669  history | grep -i ansible
 1670  history | grep -i ansible > README.md 
