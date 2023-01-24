pipeline{
	agent any
	tools{
		terraform "Terraform"
	}

	environment {
		AWS_key = credentials("AWS")
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
