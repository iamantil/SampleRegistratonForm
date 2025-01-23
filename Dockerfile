FROM tomcat:8-jdk8
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY ROOT.war /usr/local/tomcat/webapps
# Create a directory for the SSL certificates
RUN mkdir -p /usr/local/tomcat/ssl
# Copy the certificate and key into the container
COPY certificate.pem /usr/local/tomcat/ssl/certificate.pem
COPY privatekey.pem /usr/local/tomcat/ssl/privatekey.pem
COPY ch_chain.pem /usr/local/tomcat/ssl/ca_chain.pem
# Combine the certificate and key into a PKCS12 keystore
RUN apt-get update && apt-get install -y openssl && \
    openssl pkcs12 -export -in /usr/local/tomcat/ssl/certificate.pem \
    -inkey /usr/local/tomcat/ssl/privatekey.pem \
    -out /usr/local/tomcat/ssl/keystore.p12 \
    -name tomcat \
    -certfile /usr/local/tomcat/ssl/ca_chain.pem \
    -password pass:changeit && \
    rm -rf /var/lib/apt/lists/*
# Update Tomcat configuration to use the keystore
RUN sed -i 's|</Service>|<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol" maxThreads="150" SSLEnabled="true" scheme="https" secure="true" clientAuth="false" sslProtocol="TLS" keystoreFile="/usr/local/tomcat/ssl/keystore.p12" keystorePass="changeit" keystoreType="PKCS12" /></Service>|' /usr/local/tomcat/conf/server.xml
CMD ["catalina.sh", "run"]
