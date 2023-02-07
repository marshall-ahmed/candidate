FROM adoptopenjdk/openjdk11:ubi

COPY ./build/libs/*.jar candidate-service.jar/

EXPOSE 80

CMD ["java","-Xmx50m","-jar","candidate-service.jar"]

#ENTRYPOINT ["java","-jar","candidate-service.jar"]
