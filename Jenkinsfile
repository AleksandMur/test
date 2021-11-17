pipeline {
  
    agent any
    tools {
       maven 'maven'
    }
    stages {
    
        stage("build jar") {
       
            steps {
                echo 'building the image ...'
                sh 'mvn package'
            }  
        }
        stage("build image") {
       
            script {
                echo "test the application ..."
                withCredentials([usernamePassword(credentialsId: 'docker-login', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh 'docker build -t aleksandrmur/demo-app:jma-2.0 .'
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh 'docker push aleksandrmur/demo-app:jma-2.0'
                }
            }  
        }
        stage("deploy") {
       
            steps {
                echo 'deploy the application ...'
            }  
        } 
    }
      
}  
  
