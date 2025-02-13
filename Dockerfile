FROM tomcat:8-jdk8

# Remove the default webapps
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the web application
COPY ROOT.war /usr/local/tomcat/webapps

# Create a directory for the SSL certificates
RUN mkdir -p /usr/local/tomcat/ssl

# Copy the certificate and privatekey into the container
COPY certificate.pem /usr/local/tomcat/ssl/certificate.pem
COPY privatekey.pem /usr/local/tomcat/ssl/privatekey.pem

# Install OpenSSL
RUN apt-get update && apt-get install -y openssl && \
    rm -rf /var/lib/apt/lists/*

# Add the PPA repository for OpenJDK 8
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update

# Install JDK for keytool
RUN apt-get install -y openjdk-8-jdk

# Create a separate truststore and import the certificate
RUN keytool -import -alias root -keystore /usr/local/tomcat/ssl/truststore.jks -file /usr/local/tomcat/ssl/certificate.pem -storepass changeit -noprompt

# Update Tomcat configuration to use the truststore
RUN sed -i 's|</Service>|<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol" maxThreads="150" SSLEnabled="true" scheme="https" secure="true" clientAuth="false" sslProtocol="TLS" keystoreFile="/usr/local/tomcat/ssl/privatekey.pem" keystorePass="changeit" truststoreFile="/usr/local/tomcat/ssl/truststore.jks" truststorePass="changeit" truststoreType="JKS" /></Service>|' /usr/local/tomcat/conf/server.xml

CMD ["catalina.sh", "run"]
