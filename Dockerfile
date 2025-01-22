FROM tomcat:8-jdk8
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY ROOT.war /usr/local/tomcat/webapps
# Create a directory for the SSL certificates
RUN mkdir -p /usr/local/tomcat/ssl
# Copy the certificate and key into the container
COPY certificate.pem /usr/local/tomcat/ssl/certificate.pem
COPY privatekey.pem /usr/local/tomcat/ssl/privatekey.pem
# Update Tomcat configuration to use the SSL certificate
RUN sed -i 's|</Service>|<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol" maxThreads="150" SSLEnabled="true" scheme="https" secure="true" clientAuth="false" sslProtocol="TLS" keystoreFile="/usr/local/tomcat/ssl/certificate.pem" keystorePass="changeit" keyAlias="tomcat" keystoreType="PKCS12" keyPass="changeit" /></Service>|' /usr/local/tomcat/conf/server.xml
CMD ["catalina.sh", "run"]
