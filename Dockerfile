# Use an official Maven image as the base image
FROM maven:3.6.3-jdk-8

HEALTHCHECK NONE

# Set the working directory to /app
WORKDIR /app

# Copy the pom.xml file to the container
COPY pom.xml .

# Download the dependencies
RUN rm -rf ~/.m2

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
