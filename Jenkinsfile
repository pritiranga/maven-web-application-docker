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

	} //stages closing
} //pipeline closing