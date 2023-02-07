FROM adoptopenjdk/openjdk11:ubi

COPY ./build/libs/*.jar candidate-service.jar/

EXPOSE 80

ENTRYPOINT ["java","-jar","/candidate-service.jar"]