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
                slack.stage_message(message:"terraform resources applied")
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
                    slack.stage_message(message:"terraform resources destroyed")
                }
            }
        }


        

    }
    post {
        always {
            script{
                slack.always_case(message:"always called")
            }
        }
        success {
            script{
                slack.slack_username("SharjeeL")
                slack.success_build()   
            }
        }
        failure {
            script{
                slack.slack_username("SharjeeL")
                slack.build_failure() 
            }
        }

    
    
    }
}
