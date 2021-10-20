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
	    
	  stage ('Build') {
            steps {
                sh 'mvn clean package'
            }
        } 
      stage ('Deploy-To-Tomcat') {
            steps {
		    sshagent(['tomcat']){
                    sh 'scp -o StrictHostKeyChecking=no cd /var/lib/jenkins/workspace/CICD\ Pipeline/target/JavaVulnerableLab/  /opt/tomcat/webapps/webapp.war'
              }      
           }       
    }
	    
     }
}
