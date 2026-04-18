FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
# Jenkins 8080 lo undi kabatti, manam 8081 use chesthunnam
EXPOSE 8081
ENTRYPOINT ["java", "-Djava.awt.headless=true", "-jar", "app.jar", "--server.port=8081"]
