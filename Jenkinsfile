properties([parameters([booleanParam(defaultValue: false, description: 'include r4r4r4rinit step', name: 'includeInit'), choice(choices: ['apply', 'destroy'], description: 'select apply or destroy which to include', name: 'applyORdestroy')])])

pipeline{
    agent {
         label 'windows'
    }

    tools {
        terraform 'terraformwindows',
        git 'gitwindows'
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
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
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
                sh 'terraform apply --auto-approve'
            }
            }



        stage('Terraform destroy'){
            when{
                expression{
                    params.applyORdestroy == 'destroy'
                }
            }
            steps{
                sh 'terraform destroy --auto-approve'
            }
        }



    }
}
