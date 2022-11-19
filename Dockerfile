# Pull base image 
FROM tomcat:8.0.20-jre8

# Maintainer 
MAINTAINER "divinlonji@gmail.com"

# Copy artifacet from the Jenkins target folder into the directory of the tomcat docker conatiner.
COPY ./target/*.war /usr/local/tomcat/webapps
