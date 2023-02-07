FROM adoptopenjdk/openjdk11:ubi

COPY --chown=appuser ./build/libs/candidate.jar .

RUN chmod 400 ms-ecourt-document.jar

ENTRYPOINT ["java","-jar","candidate.jar"]

#FROM adoptopenjdk/openjdk11:ubi

#VOLUME /tmp

#COPY ./build/libs/*.jar candidate-service.jar/

#EXPOSE 80

#ENV JAVA_OPTS=""

#ENTRYPOINT ["java","-jar","/candidate-service.jar"]

