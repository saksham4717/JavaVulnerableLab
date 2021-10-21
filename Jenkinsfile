pipeline {
    agent any
    tools { 
        maven 'Maven' 
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                ''' 
            }
        }
	    stage ('Check-Git-Secrets') {
		    steps {
	        sh 'rm trufflehog || true'
		sh 'docker pull gesellix/trufflehog'
		sh 'docker run -t gesellix/trufflehog --json https://github.com/devopssecure/webapp.git > trufflehog'
		sh 'cat trufflehog'
	    }
	    }
	    
	  stage ('Build') {
            steps {
                sh 'mvn clean package'
            }
        } 
	    
	   stage ('Source-Composition-Analysis') {
		steps {
		     sh 'rm owasp-* || true'
		     sh 'wget https://raw.githubusercontent.com/yugansh23/JavaVulnerableLab/master/owasp_dependency_check.sh'	
		     sh 'chmod +x owasp-dependency-check.sh'
		     sh 'bash owasp-dependency-check.sh'
		     sh 'cat /var/lib/jenkins/OWASP-Dependency-Check/reports/dependency-check-report.xml'
		}
	}
      stage ('Deploy-To-Tomcat') {
            steps {
		    sshagent(['tomcat']){
                    sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/CICDPipeline/target/JavaVulnerableLab.war  /opt/tomcat/webapps/'
              }      
           }       
    }
	    
     }
}
