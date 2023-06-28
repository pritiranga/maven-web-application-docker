# Use a base image with Apache Tomcat and Java pre-installed
FROM tomcat:8.0.20-jre8

# Remove the default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the project files to the container
COPY . .

# Install Maven
RUN apt-get update && apt-get install -y maven

# Build the project
RUN mvn clean package && \
    cp target/maven-web-application.war /usr/local/tomcat/webapps/maven-web-application.war

# Expose the port on which Tomcat will run (change if necessary)
EXPOSE 8082

# Start Tomcat
CMD ["catalina.sh", "run"]

