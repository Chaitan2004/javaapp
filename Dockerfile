# Use an official Maven image to build the project
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY . .
RUN mvn clean package

# Use an official OpenJDK runtime as the base image
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/javaapp-1.0-SNAPSHOT.jar ./javaapp.jar

# Run the application
CMD ["java", "-jar", "javaapp.jar"]