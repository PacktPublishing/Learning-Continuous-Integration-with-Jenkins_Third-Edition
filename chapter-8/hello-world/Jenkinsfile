pipeline {
    agent {
        kubernetes {
            // Use a label to distinguish this pod template
            label 'ci-template'
            yaml '''
apiVersion: v1
kind: Pod
metadata:
  # Note: The name and possibly namespace for the Pod should be added here.
  name: ci-pod
spec:
  containers:
    - name: node
      image: node:latest
      command:
        - sleep
      args:
        - 99d

    - name: sonar-scanner-cli
      image: sonarsource/sonar-scanner-cli:latest
      command:
        - sleep
      args:
        - 99d

    - name: kaniko
      image: gcr.io/kaniko-project/executor:debug
      command:
        - sleep
      args:
        - 99d
      volumeMounts:
        - name: kaniko-secret
          mountPath: /kaniko/.docker

  restartPolicy: Never
  
  volumes:
    - name: kaniko-secret
      secret:
        secretName: artifactory-credentials
        items:
          - key: .dockerconfigjson
            path: config.json
            '''
        }
    }

    stages {
        stage('Unit testing') {
            steps {
                container('node') {
                    sh '''
                        cd ./backend/
                        npm install
                        npm run test
                    '''
                }
            }
        }

        stage('SonarQube analysis') {
            steps {
                container('sonar-scanner-cli') {
                    withSonarQubeEnv('Default SonarQube Server') {
                        sh """
                            sonar-scanner \
                            -Dsonar.projectKey=Hello-World \
                            -Dsonar.sources=backend/,frontend/,database-init/ \
                            -Dsonar.exclusions=test-output/  \
                            -Dsonar.tests=unit-tests/ \
                            -Dsonar.host.url=${env.SONAR_HOST_URL} \
                            -Dsonar.login=${env.SONAR_AUTH_TOKEN} \
                            -Dsonar.javascript.lcov.reportPaths=./test-output/coverage/lcov.info
                        """
                    }
                }
            }
        }

        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Build and Publish Docker Images') {
            parallel {
                stage('Frontend') {
                    steps {
                        container(name: 'kaniko', shell: '/busybox/sh') {
                            sh '''#!/busybox/sh
                                VERSION=$(grep '"version":' ./backend/package.json | head -1 | awk -F: '{ print $2 }' | sed 's/[", ]//g')
                                /kaniko/executor --context `pwd`/frontend --dockerfile=Dockerfile --insecure --skip-tls-verify --insecure-registry 4.231.77.212 --skip-tls-verify-registry 4.231.77.212 --destination=4.231.77.212/docker-local/frontend:$VERSION-$BUILD_NUMBER --image-name-with-digest-file=frontend-image-file
                            '''
                        }
                    }
                }

                stage('Backend') {
                    steps {
                        container(name: 'kaniko', shell: '/busybox/sh') {
                            sh '''#!/busybox/sh
                                VERSION=$(grep '"version":' ./backend/package.json | head -1 | awk -F: '{ print $2 }' | sed 's/[", ]//g')
                                /kaniko/executor --context `pwd`/backend --dockerfile=Dockerfile --insecure --skip-tls-verify --insecure-registry 4.231.77.212 --skip-tls-verify-registry 4.231.77.212 --destination=4.231.77.212/docker-local/backend:$VERSION-$BUILD_NUMBER --image-name-with-digest-file=backend-image-file
                            '''
                        }
                    }
                }
            }
        }

        stage('Publish build info') {
            steps {
                rtCreateDockerBuild (
                    serverId: 'Default Artifactory Server',
                    sourceRepo: 'docker-local',
                    kanikoImageFile: "frontend-image-file"
                )
                rtCreateDockerBuild (
                    serverId: 'Default Artifactory Server',
                    sourceRepo: 'docker-local',
                    kanikoImageFile: "backend-image-file"
                )
                rtPublishBuildInfo (
                    serverId: 'Default Artifactory Server'
                )
            }
        } 
    }

    post {
        always {
            // This collects the JUnit XML report and displays it in Jenkins
          junit '**/test-output/unit-test-report/junit-test-results.xml'
        }
    }
}