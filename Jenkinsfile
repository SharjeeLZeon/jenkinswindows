@Library("shared_library") _
properties([parameters([booleanParam(defaultValue: false, description: 'include init step', name: 'includeInit'), choice(choices: ['apply', 'destroy'], description: 'select apply or destroy which to include', name: 'applyORdestroy')])])

pipeline{
    agent {
         label 'linuxs'
    }

    tools {
        terraform 'terraformlinux'
    }  


    
    stages{

        
        stage("Git Checkout"){
            steps{
                git credentialsId: 'e4583a96-72a0-4803-8ccc-66d5f94d33b5', url: 'https://github.com/SharjeeLZeon/jenkinswindows'
            }
        }


        stage('Terraform init'){
            when{
                expression{
                    params.includeInit == true
                }
                
            }
            steps{
                script{
                    terraform(1)
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                terraform(2)
            }
        }
        stage('Proceed next stages') {
            steps {
                input('Do you want to proceed?')
            }
        }


        stage('Terraform apply'){
            when{
                expression{
                    params.applyORdestroy == 'apply'
                }
            }
            steps{
                terraform(3)
                slackSend message: 'aws resources created successfully'
                
            }
            }



        stage('Terraform destroy'){
            when{
                expression{
                    params.applyORdestroy == 'destroy'
                }
            }
            steps{
                terraform(4)
                slackSend message: 'aws resources destroyed successfully'
                
            }
        }


        

    }
    post {
        success {
            script{
                username = "sharjeel"
                slackSend color: '#AAFF00', message: "Username: ${username}"
                slackSend color: '#AAFF00', message: "Build Successful - Job Name:${env.JOB_NAME}  Build Number:${env.BUILD_NUMBER}  Build URL:(<${env.BUILD_URL}|Open>)"
            }
            }
        failure {
            script{
                username = "sharjeel"
                slackSend color: '#FF0000', message: "Username: ${username}"
                slackSend color: '#FF0000', message: "Build failure occured - Job Name:${env.JOB_NAME}  Build Number:${env.BUILD_NUMBER}  Build URL:(<${env.BUILD_URL}|Open>)"


            }
            }
    
    
    }
}
