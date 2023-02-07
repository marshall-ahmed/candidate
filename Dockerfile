FROM adoptopenjdk/openjdk11:ubi

VOLUME /tmp

COPY ./build/libs/*.jar ./build/libs/candidate-service.jar/

EXPOSE 80

ENV JAVA_OPTS=""

ENTRYPOINT ["java","-jar","./build/libs/candidate-service.jar"]

