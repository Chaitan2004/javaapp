# 🛠 Build Stage
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

# 🚀 Production Stage
FROM openjdk:11-jre-slim
WORKDIR /app

# Copy built JAR from the build stage
COPY --from=build /app/target/javaapp-1.0-SNAPSHOT.jar ./javaapp.jar

# Expose port for web service
EXPOSE 8080

# Start the Java application
CMD ["java", "-jar", "javaapp.jar"]
