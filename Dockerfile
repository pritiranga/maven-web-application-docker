# Use a base image with Apache Tomcat and Java pre-installed
FROM tomcat:8.0.20-jre8

# Remove the default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the project files to the container
COPY . .

# Install Maven
RUN apt-get update && \
    apt-get install -y gnupg && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3B4FE6ACC0B21F32 && \
    echo "deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu bionic main" | tee /etc/apt/sources.list.d/openjdk-r-ppa.list && \
    echo "deb http://ppa.launchpad.net/linuxuprising/java/ubuntu bionic main" | tee /etc/apt/sources.list.d/linuxuprising-java.list && \
    apt-get update && \
    echo oracle-java11-installer shared/accepted-oracle-license-v1-2 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java11-installer && \
    apt-get install -y maven

# Build the project
RUN mvn clean package && \
    cp target/maven-web-application.war /usr/local/tomcat/webapps/maven-web-application.war

# Expose the port on which Tomcat will run (change if necessary)
EXPOSE 8082

# Start Tomcat
CMD ["catalina.sh", "run"]
