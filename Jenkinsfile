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
                    sh 'scp -o  target/*.war osboxes@192.168.113.146:/home/opt/tomcat/webapps/webapp.war'
              }      
           }       
    }
	    
     }
}
