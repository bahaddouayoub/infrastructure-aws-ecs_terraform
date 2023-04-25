#!/usr/bin/env groovy

pipeline {
    agent any
    environment { 	
                AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
            }
    stages {
    stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/bahaddouayoub/micros-services-infrastructure.git"
                        }
                    }
                }
            }
    stage('Terraform Formate') {
      steps {
        sh 'terraform fmt'
      }
    }
    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }
   stage('Terraform Validate'){
    steps{
        sh"terraform validate"
    }
    }
    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -out=tfplan'
      }
    }
    stage('Terraform Apply') {
      steps {
        sh 'terraform apply -auto-approve tfplan'
      }
    }
  }
}