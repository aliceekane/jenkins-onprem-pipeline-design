pipeline {
    agent any

    environment {
        REGISTRY = "nexus.lab.local"
        IMAGE_NAME = "demo-app"
        IMAGE_TAG = "${BUILD_NUMBER}"
        K8S_NAMESPACE = "lab"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
    }
}
        stage('Validate') {
            steps {
                echo 'Installing dependencies...'
                sh 'pip install -r examples/app/requirements.txt'
    }
}
    stage('Unit Test') {
        steps {
            echo 'Running validation tests...'
            sh 'python -m py_compile examples/app/app.py'
    }
}


    }

    post {

    }
}