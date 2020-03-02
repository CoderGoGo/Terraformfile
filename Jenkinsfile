node('master') {
    
    stage('terraform init') {
 
          sh 'terraform init ../terraform'
          sh 'terraform apply -auto-approve ../terraform'
          sh 'terraform output > ip'
	  sh 'cat ip | cut -d \' \' -f 3 > ip_instance'
	  sh 'cd /home/ubuntu/deployAnsible'
	  sh 'sed -i "s/ansible_host=/ansible_host=$(cat /var/lib/jenkins/workspace/CreateEc2Instance/ip_instance)/g" hosts'
    }
    }
