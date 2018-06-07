FROM docker.io/maven
RUN yum install git
RUN git clone https://github.com/Eswar6/Maven.git
WORKDIR Maven
RUN mvn clean install
