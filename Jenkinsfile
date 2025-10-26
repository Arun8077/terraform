pipeline {
    agent any

    parameters {
        choice(
            name: 'ENV',
            choices: ['dev', 'prod'],
            description: 'Select environment to deploy'
        )
        booleanParam(
            name: 'APPLY', 
            defaultValue: false,
            description: 'Apply Terraform changes'
        )
        booleanParam(
            name: 'DESTROY', 
            defaultValue: false,
            description: 'Destroy Terraform-managed resources'
        )
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'terraform_feature',
                    url: 'https://github.com/Arun8077/terraform.git',
                    credentialsId: 'github-cred'
            }
        }

        stage('Terraform Steps') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'aws-cred',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    dir("envs/${params.ENV}") {
                        sh 'terraform init -input=false'
                        sh 'terraform validate'
                        sh 'terraform plan -out=tfplan -var-file=terraform.tfvars'

                        script {
                            if (params.APPLY) {
                                sh 'terraform apply -auto-approve tfplan'
                            }
                            if (params.DESTROY) {
                                sh 'terraform destroy -auto-approve -var-file=terraform.tfvars'
                            }
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Terraform pipeline for environment ${params.ENV} completed."
        }
    }
}
