pipeline {
    agent any


    stages {
        stage ("Deploy branches") {
            agent any

                when {
                    allOf {
                        not { branch 'master' }
                        changeset "folder_1/**"
                            expression {
                                sh(returnStatus: true, script: 'git diff  origin/master --name-only | grep --quiet "^folder_1/.*"') == 0
                            }
                        expression {
                            sh(returnStatus: true, script: 'git diff origin/master --name-only | grep --quiet --invert-match "^folder_1/.*"') == 1
                        }
                    }
                }

            steps {
                echo 'ONLY FOLDER 1 CHANGED'
            }
        }
    }
}
