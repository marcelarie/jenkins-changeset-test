pipeline {
    agent any

    environment {
        APPS_WITH_NO_CHANGES = sh (
            script: './check-single-app-change.sh && cat apps_with_no_changes.txt',
            returnStdout: true
        ).trim()
    }

    stages {
        stage ("check environment variable") {
            agent any

            steps {
                echo "APPS WITH NO CHANGES: $APPS_WITH_NO_CHANGES"
            }
        }

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
