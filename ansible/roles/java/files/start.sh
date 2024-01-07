#!/bin/bash

JAR_FILE=/home/ubuntu/spring-petclinic-3.1.0-SNAPSHOT.jar
APP_PROPERTIES=/opt/application.properties
PROPERTIES_SCRIPT=/home/ubuntu/properties.py

sudo python3 ${PROPERTIES_SCRIPT}

sudo java -jar "${JAR_FILE}" --spring.config.location="${APP_PROPERTIES}" --spring.profiles.active=mysql &