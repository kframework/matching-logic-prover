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
    stage('Download SMT solvers') {
      steps {
        ansiColor('xterm') {
          sh 'cd prover && ./lib/ci-dependencies'
        }
      }
    }
    stage('SMTLIB Tests') {
      steps {
        ansiColor('xterm') {
          sh '''#!/bin/bash
                   cd prover \
                && PATH="$(pwd)/.build/local/bin/:$PATH" ./build smtlib2-tests
             '''
        }
      }
    }
    stage('Prover Tests') {
      steps {
        ansiColor('xterm') {
          sh '''#!/bin/bash
                   cd prover \
                && PATH="$(pwd)/.build/local/bin/:$PATH" ./build -k 0
             '''
        }
      }
    }
  }
}
