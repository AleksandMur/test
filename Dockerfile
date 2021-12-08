
FROM openjdk:8-jre-alpine

EXPOSE 8080

COPY ./target/maven-simple-*.jar /usr/app/
WORKDIR /usr/app

ENTRYPOINT ["java", "-jar", "maven-simple-0.2-*.jar"]
