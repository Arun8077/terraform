pipeline {
    agent any

    parameters {
        booleanParam(
            name: 'APPLY', 
            defaultValue: false, 
            description: 'Apply Terraform changes? If false, only plan will run'
        )
        booleanParam(
            name: 'DESTROY',
            defaultValue: false,
            description: 'Destroy Terraform-managed resources after creation'
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

        stage('Debug Workspace') {
            steps {
                dir('resource-ec2') {
                    sh 'ls -l'
                }
            }
        }

        stage('Terraform Steps') {
            steps {
                // Inject AWS credentials
                withCredentials([usernamePassword(
                    credentialsId: 'aws-cred',        // Jenkins credential ID
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    dir('resource-ec2') {
                        sh 'terraform init -input=false'
                        sh 'terraform validate'
                        sh 'terraform plan -out=tfplan'

                        script {
                            if (params.APPLY) {
                                echo "Applying Terraform changes..."
                                sh 'terraform apply -auto-approve tfplan'
                            } else {
                                echo "APPLY is false, skipping terraform apply"
                            }

                            if (params.DESTROY) {
                                echo "Destroying Terraform-managed resources..."
                                sh 'terraform destroy -auto-approve'
                            } else {
                                echo "DESTROY is false, skipping terraform destroy"
                            }
                        }
                    }
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
