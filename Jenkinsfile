pipeline {
    agent any

    environment {
        POSTGRES_HOST = 'postgres'
        POSTGRES_DB = 'laravel'
        POSTGRES_USER = 'postgres'
        POSTGRES_PASSWORD = 'secret'
        ELASTICSEARCH_HOST = 'elasticsearch'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    dockerComposeUp()
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    sh 'docker-compose exec app composer install'
                    sh 'docker-compose exec app npm install'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    sh 'docker-compose exec app php artisan migrate --env=testing'
                    sh 'docker-compose exec app php artisan test'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "Deploying your app..."
                    // Add deployment commands here (e.g., pushing to production server)
                }
            }
        }
    }

    post {
        always {
            script {
                dockerComposeDown()
            }
        }
    }
}

def dockerComposeUp() {
    sh 'docker-compose up -d'
}

def dockerComposeDown() {
    sh 'docker-compose down'
}
