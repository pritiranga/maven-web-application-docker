pipeline{

agent any
	
	tools{
		maven 'Maven'
		terraform 'Terraform'
	}
	
	environment{
		AWS_KEYS = credentials( "AWS")
		ECR_REG = 'https://109968515111.dkr.ecr.us-east-1.amazonaws.com'
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
	
	
// 		stage('Software Composition Anaylsis'){
// 			steps{
// 				script{	
// 					dependencyCheck additionalArguments: '--format XML', odcInstallation: 'Dependency-Checker'
// 					dependencyCheckPublisher pattern: ''
// 				}
// 			}
// 		}
	

		stage ('Creating ECR'){
			steps{
				sh 'terraform init'
				sh 'terraform plan'
				sh 'terraform apply --auto-approve'
			}
		}
		
        	stage('Build Docker Image') {
            		steps {
                		sh 'docker build -t demo-webapp-docker .'
                		sh 'docker image ls'
            		}
        	}
		
		stage('Push Docker Image to ECR'){
			steps{
				sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(ECR_REG)'
				sh 'docker push demo-webapp-docker'
			}
		}
		
	}// stages closing
} //pipeline closing
	
  
