# Use an official Maven image as the base image
FROM maven:3.6.3-jdk-8

RUN useradd -ms /bin/bash priti
RUN echo 'priti:123' | chpasswd
RUN usermod -aG priti $USER
USER priti

HEALTHCHECK NONE

# Set the working directory to /app
WORKDIR /app

# Copy the pom.xml file to the container
COPY pom.xml .

# Download the dependencies
RUN mvn dependency:go-offline

# Copy the rest of the project files to the container
COPY . .

# Build the Maven project
RUN mvn package

# Use an official Tomcat image
FROM tomcat:9.0.39-jdk8

# Copy the built .war file from the Maven image to the Tomcat image
COPY --from=0 /app/target/*.war /usr/local/tomcat/webapps/

# Start the Tomcat server
CMD ["catalina.sh", "run"]
