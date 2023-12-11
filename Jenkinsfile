@Library('devops-projects-shared-lib') _

pipeline {
    agent {
        label 'docker'
    }

    tools {
        terraform 'Terraform v1.6.5'
    }

    parameters {
        choice choices: ['create', 'destroy'], name: 'action'
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

        stage('plan'){
            when { expression { params.action == 'create' } } 
            steps {                
                sh """
                    cd create-storage                    
                    terraform plan
                """
            }
        }
    }
}