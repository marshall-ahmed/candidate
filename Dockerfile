FROM adoptopenjdk/openjdk11:latest

RUN mkdir /opt/app

COPY ./build/libs/candidate.jar /opt/app/

CMD ["java", "-jar", "/opt/app/candidate.jar"]


