pipeline{
	agent any
	tools{
		terraform "Terraform"
	}

	stages{
		stage("Check Terraform Version"){
			steps{
				sh 'terraform --version'
			}
		}

		stage("Terraform init"){
			steps{
				sh 'terraform init'
			}
		}

	} //stages closing
} //pipeline closing
