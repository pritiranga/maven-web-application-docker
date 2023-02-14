pipeline{

agent any
	
	tools{
		maven 'Maven'
		terraform 'Terraform'
	}
	
	environment{
		AWS_KEYS = credentials( "AWS")
		ECR_REGISTRY = '109968515111.dkr.ecr.us-east-1.amazonaws.com'
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
// 				script{	
// 					dependencyCheck additionalArguments: '--format XML', odcInstallation: 'Dependency-Checker'
// 					dependencyCheckPublisher pattern: ''
// 				}
				echo 'SCA Working'
			}
		}
		
       		stage('Unit Testing') {
            		steps{
                    		junit(testResults: 'build/test-results/test/*.xml', allowEmptyResults : true, skipPublishingChecks: true)
           		}
//             		post {
//                 		success {
//                     			publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'build/reports/tests/test/', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
//         			}
//       			}
    		}
		
						
		stage ('Creating ECR'){
			steps{
				sh 'terraform init'
				sh 'terraform plan'
				sh 'terraform apply --auto-approve'
			}
		}
		
		stage ('Docker File Scan') {
			steps{
				//sh 'pip3 install checkov'
				sh 'checkov -f main.tf -f Dockerfile'
				sh 'checkov --skip-check LOW MEDIUM'
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
				sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin "$ECR_REGISTRY"'
				sh 'docker tag demo-webapp-docker:latest $ECR_REGISTRY/demo-webapp-docker:latest'
				sh 'docker push $ECR_REGISTRY/demo-webapp-docker:latest'
			}
		}
		
	}// stages closing
} //pipeline closing
	
  
