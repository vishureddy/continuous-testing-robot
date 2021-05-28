pipeline {
  agent any
  environment {
    QA_SERVER = 'https://jsonplaceholder.typicode.com'
  }
  stages {
	  stage('Pre-Testing -- getting dependency packages'){
		  steps{
			  echo 'Setting up env --- getting required file to perform testing'
		  }
	  }
	  	stage('Testing - Source Files') {
			  steps{
				  echo 'Performing Tests'
			  }
		  }
		  stage('Build && Sonar Qube Analysis') {
			  steps {
				  echo 'Building Executables'
			  }
		  }
		  stage ("Buiding Docker Image & Pushing to local docker Registry"){
			  steps{
				  echo 'Buiding Docker Image... and pushing to local repo'
			  }
		  }
			stage("Deploying Application into QA Environment using HELM Charts") {

			steps {
			  sh 'helm install goapp/ --values goapp/values.yaml --generate-name'
			}

			}

	    stage('Run Robot Tests') {
	      steps {
		        	sh 'python3 -m robot.run --NoStatusRC --variable base_url:${QA_SERVER} --outputdir reports .'             
		        	sh 'exit 0'
	      		}
	      post {
        	always {
		        script {
		          step(
			            [
			              $class              : 'RobotPublisher',
			              outputPath          : 'reports',
			              outputFileName      : '**/output.xml',
			              reportFileName      : '**/report.html',
			              logFileName         : '**/log.html',
			              disableArchiveOutput: false,
			              passThreshold       : 50,
			              unstableThreshold   : 40,
			              otherFiles          : "**/*.png,**/*.jpg",
			            ]
		          	)
		        }
	  		}		
	    }
	}    
  }
  
}
