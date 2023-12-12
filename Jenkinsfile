@Library('devops-projects-shared-lib') _

pipeline {
    agent {
        label 'docker'
    }
    tools {
        terraform 'Terraform v1.6.5'
    }

<<<<<<< HEAD
    parameters {
        choice choices: ['create', 'destroy'], name: 'action'
    }

    environment {
        az_svc = credentials('azure_service_principle')
    }

=======
>>>>>>> parent of be8ac1c (plan step added 2)
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

        stage('init'){
            steps {                
                sh """
                    cd create-storage                    
                    terraform init
                """
            }
        }

        stage('plan'){
            when { expression { params.action == 'create' } } 
            steps { 
                                sh """
                    echo ${az_svc_CLIENT_ID}
                    echo ${az_svc_CLIENT_SECRET}
                    echo ${az_svc_TENANT_ID}
                    echo ${az_svc_SUBSCRIPTION_ID}
                """
            }
        }
    }
}