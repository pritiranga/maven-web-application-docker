pipeline{

agent any
	
	tools{
		maven 'Maven'
		terraform 'Terraform'
	}
	
	environment{
		AWS_KEYS = credentials( "aws")
		IMAGE_REPO_NAME = var.image_repo_name
		IMAGE_TAG = var.image_tag
		
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
                		sh 'docker build --force-rm -t "$(IMAGE_REPO_NAME):latest" .'
                		sh 'docker image ls'
            		}
        	}
	
         	stage('Logging into AWS ECR') {
            		steps {
                		script {
					withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'AWS-keys', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
        					sh 'docker push "$(IMAGE_REPO_NAME):latest"'
    					}
                		}  
            		}
        	}
		
	}// stages closing
} //pipeline closing
	
  
