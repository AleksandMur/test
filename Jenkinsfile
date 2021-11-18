pipeline {
  
    agent any
    tools {
       maven 'maven'
    }
    stages {
        stage("increment version") {
            steps {
                script {
                    sh 'mvn build-helper:parse-version versions:set \
                    -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                    versions:commit'
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                }    
            }  
        }        
        
        stage("build jar") {      
            steps {
                script {
                    echo 'building the image ...'
                    sh 'mvn package'
                }    
            }  
        }
        stage("build image") {
            steps {
                script {
                    echo "test the application ..."
                    withCredentials([usernamePassword(credentialsId: 'docker-login', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "docker build -t aleksandrmur/demo-app:$IMAGE_NAME ."
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh "docker push aleksandrmur/demo-app:$IMAGE_NAME"
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
  
