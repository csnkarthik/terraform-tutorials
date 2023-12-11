@Library('devops-projects-shared-lib') _

pipeline {
    agent {
        label: 'docker'
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
    }
}