# Stage 1: Build the application
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
# Copy only the files needed to build
COPY pom.xml .
COPY src ./src
# Build the JAR
RUN mvn clean package -DskipTests

# Stage 2: Create the final image
FROM eclipse-temurin:21-jdk
WORKDIR /app
# Copy the JAR from the 'build' stage
COPY --from=build /app/target/hello-spring-*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]