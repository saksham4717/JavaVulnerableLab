FROM tomcat

COPY . .

RUN apt-get update ; apt-get install maven default-jdk -y ; update-alternatives --config javac

RUN mvn clean package ; cp /home/jenkins/workspace/CICDPipeline/target/JavaVulnerableLab.war  /opt/tomcat/webapps/

CMD ["catalina.sh","run"]
