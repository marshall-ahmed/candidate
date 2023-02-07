FROM adoptopenjdk/openjdk11:latest
RUN mkdir /opt/app
COPY ./build/libs/candidate.jar /opt/app/
CMD ["java", "-jar", "/opt/app/candidate.jar"]

#FROM adoptopenjdk/openjdk11:ubi

#VOLUME /tmp

#COPY ./build/libs/*.jar candidate-service.jar/

#EXPOSE 80

#ENV JAVA_OPTS=""

#ENTRYPOINT ["java","-jar","/candidate-service.jar"]

