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
  stage('pull docker image') {
    steps {
      sh 'docker pull springcloud/spring-cloud-dataflow-server:2.11.0-SNAPSHOT'
      sh 'docker pull springcloud/spring-cloud-skipper-server:2.11.0-SNAPSHOT'
      sh 'docker pull docker.redpanda.com/vectorized/console:latest'
      sh 'docker pull springcloud/baseimage:1.0.4'
    }
  }

  stage('Create Repositories') {
    steps {
      sh 'aws ecr create-repository --repository-name dataflow --region us-east-1'
      // sh 'aws ecr create-repository --repository-name skipper --region us-east-1'
      // sh 'aws ecr create-repository --repository-name kafka-console --region us-east-1'
      // sh 'aws ecr create-repository --repository-name app-stream --region us-east-1'
    }
  }

  stage('Tage docker image') {
    steps {
      sh 'docker tag springcloud/spring-cloud-dataflow-server:2.11.0-SNAPSHOT 858826120793.dkr.ecr.us-east-1.amazonaws.com/dataflow:dataflow'
      sh 'docker tag springcloud/spring-cloud-skipper-server:2.11.0-SNAPSHOT 858826120793.dkr.ecr.us-east-1.amazonaws.com/skipper:skipper'
      sh 'docker tag docker.redpanda.com/vectorized/console:latest 858826120793.dkr.ecr.us-east-1.amazonaws.com/kafka-console:kafka-console'
      sh 'docker tag springcloud/baseimage:1.0.4 858826120793.dkr.ecr.us-east-1.amazonaws.com/app-stream:app-stream'
    }
  }

  stage('Push docker image') {
    steps {
      
      sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 858826120793.dkr.ecr.us-east-1.amazonaws.com"
      sh 'docker push 858826120793.dkr.ecr.us-east-1.amazonaws.com/dataflow:dataflow'
      // sh 'docker push 858826120793.dkr.ecr.us-east-1.amazonaws.com/skipper:skipper'
      // sh 'docker push 858826120793.dkr.ecr.us-east-1.amazonaws.com/kafka-console:kafka-console'
      // sh 'docker push 858826120793.dkr.ecr.us-east-1.amazonaws.com/app-stream:app-stream'
      
    }
  }
  stage('Terraform Init') {
    steps {
      sh 'terraform init -reconfigure'
    }
  }
  stage('Terraform Formate') {
    steps {
      sh 'terraform fmt'
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
