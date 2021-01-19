FROM tomcat:8-jdk8
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY ROOT /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
