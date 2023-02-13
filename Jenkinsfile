pipeline{

agent any
	
	tools{
		maven 'Maven'
		terraform 'Terraform'
	}
	
	environment{
		AWS_key = credentials("AWS-keys")
	}


	


stages{

	stage ('SCM'){
		steps{
			script{
				checkout scmGit(
    					branches: [[name: 'ci']],
    					userRemoteConfigs: [[url: 'https://github.com/pritiranga/maven-web-application-docker.git']]
		  		)
			}
	  	}
   	}
	
	
	stage('Software Composition Anaylsis'){
		steps{
			script{
				
				dependencyCheck additionalArguments: '--format XML', odcInstallation: 'Dependency-Checker'
				dependencyCheckPublisher pattern: ''
			}
		}
	}
	

	stage ('Creating ECR'){
		steps{
			sh 'terraform init'
			sh 'terraform plan'
			sh 'terraform apply --auto-approve'
		}
	}
	
}// stages closing
} //pipeline closing
	
  
