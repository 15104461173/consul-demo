FROM openjdk:8-jdk-alpine3.7

ADD target/*.jar /app.jar

EXPOSE 8080