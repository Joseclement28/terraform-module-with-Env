pipeline {
    agent any 

    options{
        timestamps()
    }

    stages{

        stage('checkout'){
            steps{
                checkout scm
            }
        }

        /* ================= DEV ================= */

        stage('Terraform Init - Dev'){
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    dir('envs/dev'){
                        sh 'terraform init -reconfigure'
                    }
                }
            }
        }

        stage('Terraform Plan - Dev'){
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    dir('envs/dev'){
                        sh 'terraform plan'
                    }
                }
            }
        }

        stage('Approve Dev Apply'){
            steps{
                input message: 'Approve Terraform Apply for Dev?', ok: 'Apply'
            }
        }

        stage('Terraform Apply Dev'){
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    dir('envs/dev'){
                        sh 'terraform apply -auto-approve'
                    }    
                }
            }
        }

        /* ============ PROD ENTRY GATE ============ */

        stage('Approve START PROD'){
            steps{
                input message: 'Approve start of PROD Deployment?', ok:'Start Prod'
            }
        }

        stage('Terraform Init - PROD'){
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    dir('envs/prod'){
                        sh 'terraform init -reconfigure'
                    }
                }
            }
        }

        stage('Terraform Plan - PROD'){
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    dir('envs/prod'){
                        sh 'terraform plan'
                    }
                }
            }
        }

        stage('Approve PROD Apply'){
            steps{
                input message: 'Approve Terraform APPLY for Prod?', ok: 'Apply'
            }
        }

        stage('Terraform Apply - PROD'){
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    dir('envs/prod'){
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
    }

    post{
        success{
            echo "DEV and PROD Terraform deployments completed successfully."
        }
        failure{
            echo "DEV and PROD Terraform deployments completed successfully."
        }
        aborted{
            echo "Pipeline aborted during manual approval."
        }
    }

}