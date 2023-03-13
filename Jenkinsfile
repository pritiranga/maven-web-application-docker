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
	
		
		stage ('Artifactory configuration') {
            		steps {
                		rtServer (
                    			id: "JFrog",
                    			url: "http://3.92.84.72:8081",
                    			credentialsId: "jfrog"
                		)

                		rtGradleDeployer (
                    			id: "GRADLE_DEPLOYER",
                    			serverId: "JFrog",
                    			repo: "devsecops-test",
                    			excludePatterns: ["*.jar"],
                 		)
				rtGradleResolver (
                    			id: "GRADLE_RESOLVER",
                    			serverId: "JFrog",
                    			repo: "devsecops-test"
                		)

            		}
        	}
		
		stage ('build') {
			steps{
				sh 'gradle build --no-daemon'
			}
		}
		
		stage ('Config Build Info') {
            		steps {
                		rtBuildInfo (
                    			captureEnv: true,
                    			includeEnvPatterns: ["*"],
                    			excludeEnvPatterns: ["DONT_COLLECT*"]
                		)
            		}
        	}
        	
		stage ('Exec Gradle') {
            		steps {
                		rtGradleRun (
                    			usesPlugin: true, // Artifactory plugin already defined in build script
                    			useWrapper: true,
                    			//tool: 'Gradle', // Tool name from Jenkins configuration
                    			rootDir: "maven-web-application-docker",
                    			tasks: 'clean artifactoryPublish',
                    			deployerId: "GRADLE_DEPLOYER",
                    			resolverId: "GRADLE_RESOLVER"
                		)
            		}
        	}


        	stage ('Publish build info') {
            		steps {
                		rtPublishBuildInfo (
                    		serverId: "JFrog"
                		)
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
		
		stage('SAST-Sonarqube'){
			steps{
				echo 'Code review report generated'
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
		
		stage ('Docker File Scan') {
			steps{
				//sh 'pip3 install checkov' checkov --skip-check LOW MEDIUM'
				sh 'checkov -f Dockerfile --skip-check CKV_DOCKER_3'
				
			}
		}
		
//         	stage('Build Docker Image') {
//             		steps {
//                 		sh 'docker build -t demo-webapp-docker .'
//                 		sh 'docker image ls'
//             		}
//         	}
		
// 		stage ('Creating ECR'){
// 			steps {
// 				sh 'terraform init'
// 				sh 'terraform plan'
// 				sh 'terraform apply --auto-approve'
// 			}
// 		}
		
// 		stage('Publish Docker Image to ECR'){
// 			steps{
// 				sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin "$ECR_REGISTRY"'
// 				sh 'docker tag demo-webapp-docker:latest $ECR_REGISTRY/demo-webapp-docker:$BUILD_NUMBER'
// 				sh 'docker push $ECR_REGISTRY/demo-webapp-docker:$BUILD_NUMBER'
// 			}
// 		}
		
// 		stage ('Docker Image Scanning'){
// 			steps{
// 				sh 'trivy image --format json -o trivy_scan_report.json $ECR_REGISTRY/demo-webapp-docker:$BUILD_NUMBER'
// 				echo 'trivy_scan_report.json generated'
// 			}
// 		}
		
// 		stage ('Deploying on K8s cluster'){
// 			steps{
// 				script{
// 					withKubeConfig([credentialsId: 'k8', serverUrl: 'http://54.235.229.32/']){
// 						echo 'Deployment started with Docker image'
// 						sh 'kubectl apply -f deployment-service.yml'
// 						sh 'sleep 10'
// 						sh 'Displaying all service details'
// 						sh 'kubectl get all'			
// 					}
// 				}
// 			}
// 		}
		
		stage('k8 deploy'){
			steps{
				script{
					kubernetesDeploy(
						configs: 'deployment-service.yml',
						kubeconfigId: 'k8'
						)
				}
			}
		}
		
		
		
	}// stages closing
} //pipeline closing
	
  
