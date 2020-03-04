node('master') {
    
    stage('terraform init') {
 
          sh 'terraform init ../terraform'
          sh 'terraform apply -auto-approve ../terraform'
          sh 'terraform output > ip'
	  sh 'cat ip | cut -d \' \' -f 3 > ip_instance'
    }
	post {
      success {
        node('master') {
           telegramSend "Job \"${JOB_NAME}\": Build №${BUILD_NUMBER} Succeed. More info: ${BUILD_URL}"
         }
      }
      failure {
        node('master') {
           telegramSend "Job \"${JOB_NAME}\": Build №${BUILD_NUMBER} Failed. More info: ${BUILD_URL}"
         }
      }
   }
    }
