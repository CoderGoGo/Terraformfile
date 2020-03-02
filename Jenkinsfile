node('master') {
    
    stage('terraform init') {
 
          sh 'terraform init ../terraform'
          sh 'terraform apply -auto-approve ../terraform'
          sh 'terraform output > ip'
	  sh 'cat ip | cut -d \' \' -f 3 > ip_instance'	  
    }
    }
