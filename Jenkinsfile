pipeline{

agent any
	
	tools{
		maven 'Maven'
		terraform 'Terraform'
	}
	
	environment{
		AWS_KEYS = credentials( "AWS")
		
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
                		sh 'docker build --force-rm -t "$(var.image_repo_name):latest" .'
                		sh 'docker image ls'
            		}
        	}
	
//          	stage('Logging into AWS ECR') {
//             		steps {
//                 		script {
// 					withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'aws', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
//         					sh 'docker push "$(var.image_repo_name):latest"'
//     					}
//                 		}  
//             		}
//         	}
		
	}// stages closing
} //pipeline closing
	
  
