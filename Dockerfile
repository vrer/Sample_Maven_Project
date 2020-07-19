FROM tomcat
COPY /Sample_Project/target/*.war /usr/local/tomcat/webapps/
