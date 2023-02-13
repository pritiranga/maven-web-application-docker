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
	
	stage ('Building Docker Image and pushing to ECR') {
		steps{
			sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 109968515111.dkr.ecr.us-east-1.amazonaws.com'
			sh 'docker build -t demo-webapp-docker .'
			sh 'docker tag demo-webapp-docker:latest 109968515111.dkr.ecr.us-east-1.amazonaws.com/demo-webapp-docker:latest'
			sh 'docker push 109968515111.dkr.ecr.us-east-1.amazonaws.com/demo-webapp-docker:latest'
		}
	}
	
}// stages closing
} //pipeline closing
	
  
