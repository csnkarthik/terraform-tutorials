@Library('devops-projects-shared-lib') _

pipeline {
    agent {
        label 'docker'
    }
    parameters {
        choice choices: ['create', 'destroy'], name: 'action'
    }

    environment {
        az_svc = credentials('azure_service_principle')
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
                    terraform init
                """
            }
        }
        stage('plan'){
            when { expression { params.action == 'create' } } 
            steps {

                sh """

                    export ARM_CLIENT_ID=${az_svc_CLIENT_ID}
                    export ARM_CLIENT_SECRET=${az_svc_CLIENT_SECRET}
                    export ARM_TENANT_ID=${az_svc_TENANT_ID}
                    export ARM_SUBSCRIPTION_ID=${az_svc_SUBSCRIPTION_ID}
                    cd create-storage
                    terraform plan 
                """               
            }
        }

        stage('apply'){
            when { expression { params.action == 'create' } } 
            steps {

                sh """

                    export ARM_CLIENT_ID=${az_svc_CLIENT_ID}
                    export ARM_CLIENT_SECRET=${az_svc_CLIENT_SECRET}
                    export ARM_TENANT_ID=${az_svc_TENANT_ID}
                    export ARM_SUBSCRIPTION_ID=${az_svc_SUBSCRIPTION_ID}
                    cd create-storage
                    terraform apply -auto-approve
                """               
            }
        }
        stage('destroy'){
            
            when { expression { params.action == 'destroy' } } 
            steps {         
                script {
                    
                    def userInput = input message: 'Are you sure you wanna proceed to destory?', parameters: [booleanParam(name: 'proceed')]

                    sh "echo ${userInput}"
                    
                    if(userInput){
                        sh """
                            export ARM_CLIENT_ID=${az_svc_CLIENT_ID}
                            export ARM_CLIENT_SECRET=${az_svc_CLIENT_SECRET}
                            export ARM_TENANT_ID=${az_svc_TENANT_ID}
                            export ARM_SUBSCRIPTION_ID=${az_svc_SUBSCRIPTION_ID}
                            cd create-storage
                            terraform destroy -auto-approve
                        """
                    }else{
                        sh 'echo destory declined'
                    }
                }                       
            }
        }
    }
}
