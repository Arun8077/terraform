pipeline {
    agent any

    environment {
        // AWS credentials stored in Jenkins
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_DEFAULT_REGION    = 'ap-south-1'
    }

    parameters {
        booleanParam(
            name: 'APPLY', 
            defaultValue: false, 
            description: 'Apply Terraform changes? If false, only plan will run'
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

        stage('Terraform Init') {
            steps {
                dir('resource-ec2') {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('resource-ec2') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('resource-ec2') {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { return params.APPLY == true }
            }
            steps {
                dir('resource-ec2') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        always {
            echo 'Terraform pipeline completed.'
        }
    }
}
