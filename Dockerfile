FROM gradle:8.5-jdk17 AS build
WORKDIR /app
COPY --chown=gradle:gradle . /app
RUN gradle clean build -x test 

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
EXPOSE 8080
COPY --from=build /app/build/libs/discografia-1.war app.war
ENTRYPOINT ["java", "-jar", "app.war"]