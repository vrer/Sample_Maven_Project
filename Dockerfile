FROM docker.io/tomcat
MAINTAINER eswar
COPY simple-web-app.war /usr/local/tomcat/webapps/bujji.war
