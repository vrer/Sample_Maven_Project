FROM docker.io/centos
MAINTAINER bujji@66
RUN yum update -y
RUN yum install java -y
RUN yum install maven -y
RUN yum install git -y
WORKDIR /root
RUN git clone https://github.com/Eswar6/Maven.git
WORKDIR /root/Maven
RUN mvn clean install
