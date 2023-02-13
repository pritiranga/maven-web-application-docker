pipeline{

agent any
	
	tools{
		maven 'Maven'
		terraform 'Terraform'
	}
	
	environment{
		AWS_key = credentials("AWS-keys")
         	AWS_ACCOUNT_ID= "var.aws_account_id"
         	AWS_DEFAULT_REGION= "var.region"
         	IMAGE_REPO_NAME= "var.image_repo_name"
         	IMAGE_TAG= "var.image_tag"
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
	
         	stage('Logging into AWS ECR') {
            		steps {
                		script {
					withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'aws', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
        					AWS("--region=us-east-1 s3 ls")
    					}
                		}  
            		}
        	}
		
	}// stages closing
} //pipeline closing
	
  
