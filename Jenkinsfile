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
                script{
                    terraform(2)
                }
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
                script{
                terraform(3)
                slackSend message: 'aws resources created successfully'
                }
            }
            }



        stage('Terraform destroy'){
            when{
                expression{
                    params.applyORdestroy == 'destroy'
                }
            }
            steps{
                script{
                    terraform(4)
                    slackSend message: 'aws resources destroyed successfully'
                }
            }
        }


        

    }
    post {
        success {
            script{
                username = slack.slack_username()
                slackSend color: slack.success_color(), message: "Username: ${username}"

                slackSend color: slack.success_color(), slack.success_build(env.JOB_NAME, env.BUILD_NUMBER, env.BUILD_URL)
            }
            }
        failure {
            script{
                username = "sharjeel"
                slackSend color: slack.failure_color(), message: "Username: ${username}"
                slackSend color: slack.failure_color(), message: "Build failure occured - Job Name:${env.JOB_NAME}  Build Number:${env.BUILD_NUMBER}  Build URL:(<${env.BUILD_URL}|Open>)"


            }
            }
        always {
            script{
                slackSend color: slack.success_color(), slack.success_build(env.JOB_NAME, env.BUILD_NUMBER, env.BUILD_URL)   
                slackSend message: "dedede"
            }
        }
    
    
    }
}
