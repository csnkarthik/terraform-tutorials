@Library('devops-projects-shared-lib') _

pipeline {
    agent {
        label 'docker'
    }

    tools {
        terraform 'Terraform v1.6.5'
    }

    stages {
        stage('git checkout'){
            steps {                
                gitCheckout(
                    branch: 'main',
                    url: 'https://github.com/csnkarthik/terraform-tutorials.git'
                )
            }
        }

        stage('init'){
            steps {                
                sh """
                    cd create-storage
                    pwd
                    terraform init
                """
            }
        }
    }
}