pipeline {
  agent {
    dockerfile {
      additionalBuildArgs '--build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g)'
    }
  }
  stages {
    stage("Init title") {
      when { changeRequest() }
      steps {
        script {
          currentBuild.displayName = "PR ${env.CHANGE_ID}: ${env.CHANGE_TITLE}"
        }
      }
    }
    stage('Test') {
      steps {
        ansiColor('xterm') {
          sh '''#!/bin/bash
                   cd prover \
                && ./lib/ci-dependencies \
                && PATH="$(pwd)/.build/local/bin/:$PATH" ./build -k 0
          '''
        }
      }
    }
  }
}
