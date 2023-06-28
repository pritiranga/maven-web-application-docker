# Use a base image with Java pre-installed
FROM maven:3.8.4-openjdk-11-slim AS build

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the pom.xml file to the container
COPY pom.xml .

# Copy the project source code to the container
COPY src ./src

# Build the project and package the WAR file
RUN mvn clean install

# Use a lightweight base image with Tomcat
FROM tomcat:8.5.77-jdk11-openjdk-slim

# Remove the default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the built WAR file from the build stage to the Tomcat webapps directory
COPY --from=build /usr/src/app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose the port on which Tomcat will run
EXPOSE 8082

# Start Tomcat
CMD ["catalina.sh", "run"]
