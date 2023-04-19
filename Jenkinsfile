#!/usr/bin/env groovy

pipeline {
    agent none
    stages {
        stage('build') {
            steps {
                script {
                    echo "Building the application..."
                }
            }
        }
        stage('test') {
            steps {
                script {
                    echo "Testing the application..."
                }
            }
        }
        stage('provision infrastructure') {
            environment { 	
                AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
                // TF_VAR_env_prefix = 'test'
            }
            steps {
                script {
                    dir('.') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                    }
                }
            }
        }

    }
}
