# First stage: Build the application
FROM adoptopenjdk/openjdk11:latest AS builder
WORKDIR /app
COPY . .
RUN chmod +x mvnw
RUN ./mvnw clean package  # or gradlew build for Gradle

# Second stage: Create the runtime image
FROM adoptopenjdk/openjdk11:latest
ENV APP_HOME /usr/src/app
WORKDIR $APP_HOME
COPY --from=builder /app/target/*.jar $APP_HOME/app.jar  # Adjust path as needed
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
