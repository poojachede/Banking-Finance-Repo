pipeline {
  agent any
    tools{
      maven 'M2_HOME'
          }
               
   stages {
    stage('Git checkout') {
      steps {
         echo 'This is for cloning the gitrepo'
         git branch: 'main', url: 'https://github.com/poojachede/Banking-Finance-Repo'
                          }
            }
    stage('Create a Package') {
      steps {
         echo 'This will create a package using maven'
         sh 'mvn package'
                             }
            }

    stage('Publish the HTML Reports') {
      steps {
          publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Banking-Finance-Project/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                        }
            }
    stage('Create a Docker image') {
      steps {
        sh 'docker build -t poojachede/banking-finance-project:2.0 .'
                    }
            }
    stage('Login to Dockerhub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerlogin', passwordVariable: 'dockerpass', usernameVariable: 'dockeruser')]) {
        sh 'docker login -u ${dockeruser} -p ${dockerpass}'
                                                                    }
                                }
            }
    stage('Push the Docker image') {
      steps {
        sh 'docker push poojachede/banking-finance-project:2.0 '
                                }
            }
 
     stage('Terraform for infrastructure creation of EC2 Instance for deployment') {
      steps {
         dir('terraform-files') {
         sh 'sudo chmod 600 poojakey.pem'
         sh 'terraform init'
         sh 'terraform validate'
         sh 'terraform apply --auto-approve'
                                }
            }
        }
    }
}
