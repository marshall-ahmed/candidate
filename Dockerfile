FROM adoptopenjdk/openjdk11:ubi

VOLUME /tmp

COPY ./build/libs/*.jar candidate-service.jar /

EXPOSE 80

ENV JAVA_OPTS=""

ENTRYPOINT ["java","-jar","candidate-service.jar"]

