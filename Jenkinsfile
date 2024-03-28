
pipeline {
  agent any
    tools{
      maven 'M2_HOME'
          }
 //    environment {
 //     AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
//      AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
 //               }
   stages {
    stage('Git checkout') {
      steps {
         echo 'This is for cloning the gitrepo'
         git branch: 'master', url: 'https://github.com/challadevops1/star-agile-banking-finance.git'
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
          publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Banking-Project/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                        }
            }
    stage('Create a Docker image from the Package Insure-Me.jar file') {
      steps {
        sh 'docker build -t cbabu85/may-banking-project:2.0 .'
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
        sh 'docker push cbabu85/may-banking-project:2.0'
                                }
            }
 //   stage('Ansbile config and Deployment') {
 //     steps {
 //       ansiblePlaybook credentialsId: 'ansible-ssh', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'ansibledeploy.yml', vaultTmpPath: ''
 //                              }
//          }
      stage('Terraform creation of EC2 Instance for deployment') {
      steps {
         dir('terraform-files') {
         sh 'sudo chmod 600 learnawskey.pem'
         sh 'terraform init'
         sh 'terraform validate'
         sh 'terraform apply --auto-approve'
                                }
            }
        }
    }
}
