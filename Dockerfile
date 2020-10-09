FROM tomcat:8-jdk8
COPY ROOT.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
