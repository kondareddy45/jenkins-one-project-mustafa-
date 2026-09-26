FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /build

COPY pom.xml ./
COPY src ./src

RUN mvn clean package -DskipTests


FROM tomcat:9-jdk17

COPY tomcat-users.xml /usr/local/tomcat/conf/

COPY --from=builder build/target/*.war /usr/local/tomcat/webapps/myweb.war
