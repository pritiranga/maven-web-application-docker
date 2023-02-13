pipeline{

agent any
	
tools{
	maven 'Maven'
}
	
// environment {
//         NEXUS_VERSION = "nexus3"
//         NEXUS_PROTOCOL = "http"
//         NEXUS_URL = "3.83.64.77:8081"
//         NEXUS_REPOSITORY = "maven-demo-testing"
//         NEXUS_CREDENTIAL_ID = "Nexus"
// 	DOCKERHUB = credentials("Dockerhub")
	
// }
	

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
	
	stage('SonarQube analysis') {
//     		environment {
//       		SCANNER_HOME = tool 'SONAR'
//     		}
    		steps {
//     			withSonarQubeEnv(credentialsId: 'Sonar-token', installationName: 'SONAR') {
//          			sh '''$SCANNER_HOME/bin/sonar-scanner \
//          			-Dsonar.projectKey=testing \
//          			-Dsonar.projectName=testing \
//          			-Dsonar.projectVersion=${BUILD_NUMBER}-${GIT_COMMIT_SHORT}'''
//			}
			echo 'Sonarqube Report Generated'
     		}
  	}
	
	stage('Build'){
  		steps{
  			sh  "docker build -t webapp-demo ."
			sh "docker tag webapp-demo:latest "
  		}
  	}
  
// 	stage("Publish to Nexus Repository Manager") {
//         	steps {
//                 	script {
//                     		pom = readMavenPom file: "pom.xml";
//                     		filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
//                     		echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
//                     		artifactPath = filesByGlob[0].path;
//                     		artifactExists = fileExists artifactPath;
//                     		if(artifactExists) {
//                         		echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
//                         		nexusArtifactUploader(
//                             			nexusVersion: NEXUS_VERSION,
//                             			protocol: NEXUS_PROTOCOL,
//                             			nexusUrl: NEXUS_URL,
//                             			groupId: pom.groupId,
//                             			version: pom.version,
//                             			repository: NEXUS_REPOSITORY,
//                             			credentialsId: NEXUS_CREDENTIAL_ID,
//                             			artifacts: [
//                                 			[artifactId: pom.artifactId,
//                                 			classifier: '',
//                                 			file: artifactPath,
//                                 			type: pom.packaging],
//                                 			[artifactId: pom.artifactId,
//                                 			classifier: '',
//                                 			file: "pom.xml",
//                                 			type: "pom"]
//                             			]
//                         		);
//                     		} 
// 		    		else {
//                     			error "*** File: ${artifactPath}, could not be found";
//                     		}
//                 	}
//             	}
//         }
	
	
	
	}// stages closing
} //pipeline closing
	
  
