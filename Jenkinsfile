pipeline{
	agent any
	tools{
		terraform "Terraform"
	}

	stages{
		stage("Check TerraformVersion"){
			steps{
				sh 'terraform --version'
			}
		}

	} //stages closing
} //pipeline closing
