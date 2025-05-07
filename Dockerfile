# ---- Build Stage ----
    FROM maven:3.9.6-eclipse-temurin-17 AS build
    WORKDIR /app
    
    # Copy all project files
    COPY . .
    
    # Build the application
    RUN mvn clean package -DskipTests
    
    # ---- Run Stage ----
    FROM eclipse-temurin:17-jdk
    WORKDIR /app
    
    # Copy the built JAR from the build stage
    COPY --from=build /app/target/ci-cd-demo-1.0-SNAPSHOT.jar app.jar
    
    # Run the app
    ENTRYPOINT ["java", "-jar", "app.jar"]
    