pipeline{
	agent any
	tools{
		terraform "Terraform"
	}

	stages{
		stage("Check Terraform rsion"){
			steps{
				sh "terraform -version"
			}
		}

	} //stages closing
} //pipeline closing