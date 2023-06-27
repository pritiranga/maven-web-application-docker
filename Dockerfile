# Stage 1: Build stage
FROM maven:3.8.3-openjdk-8-slim AS build
WORKDIR /app
COPY pom.xml .
COPY . .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean install

# Stage 2: Final stage
FROM tomcat:8.0.20-jre8
COPY --from=build /app/target/maven-web-application.war /usr/local/tomcat/webapps/maven-web-application.war
