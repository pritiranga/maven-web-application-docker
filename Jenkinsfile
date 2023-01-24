pipeline{
	agent any
	tools{
		terraform "Terraform"
	}

	stages{
		stage("Check Terraform version"){
			steps{
				sh "terraform --version"
			}
		}

	} //stages closing
} //pipeline closing
