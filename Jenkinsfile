pipeline {
    agent any
    stages {
        stage('Checkout'){
            steps{
                git branch: 'main',
                url: 'https://github.com/Arun8077/terraform.git',
                credentialsId: 'github-cred'                
            }
        }

    }
}