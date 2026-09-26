FROM maven:3.9-eclipse-temurin-17 As builder
WORKDIR /build
COPY pom.xml ./
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

FROM tomcat:9-jre8
COPY tomcat-users.xml /usr/local/tomcat/conf
COPY --from=builser build/target/*.war /usr/local/tomcat/webapps/myweb.war


