pipeline {
  agent any
  environment {
    QA_SERVER = 'https://jsonplaceholder.typicode.com'
  }
  stages {
	    stage('Run Robot Tests') {
	      steps {
		        	sh 'python3 -m rflint --ignore LineTooLong .'
		        	sh 'python3 -m robot.run --variable base_url:${QA_SERVER} --outputdir reports1 .'
                    
		        	sh 'exit 0'
	      		}
	      post {
        	always {
		        script {
		          step(
			            [
			              $class              : 'RobotPublisher',
			              outputPath          : 'reports1',
			              outputFileName      : '**/output.xml',
			              reportFileName      : '**/report.html',
			              logFileName         : '**/log.html',
			              disableArchiveOutput: false,
			              passThreshold       : 80,
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
