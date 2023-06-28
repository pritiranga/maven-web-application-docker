# Use a base image with Apache Tomcat and Java pre-installed
FROM tomcat:9-jdk11-openjdk-slim

# Remove the default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Set the working directory inside the container
WORKDIR /usr/local/tomcat/webapps

# Copy the project's WAR file to the container
COPY target/maven-web-application.war ROOT.war

# Expose the port on which Tomcat will run (change if necessary)
EXPOSE 8082

# Start Tomcat
CMD ["catalina.sh", "run"]
