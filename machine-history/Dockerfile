FROM centos:7
ENV RELEASE_PATH target/machine-history-swarm.jar
RUN yum install -y \
    java-1.8.0-openjdk-headless \
  && yum clean all

WORKDIR /opt/machine-history

ADD ${RELEASE_PATH} /opt/machine-history

RUN groupadd -r duser -g 1001 \
    && useradd -u 1001 -r -g duser -d /opt/machine-history/ -s /sbin/nologin -c "Docker image user" duser \
    && chown -R duser:duser /opt/machine-history/ \
    && chgrp -R 0 /opt/machine-history && chmod -R g=u /opt/machine-history

USER 1001


EXPOSE 8080

ENV PORT_OFFSET=0
ENV LOGGING_LEVEL=INFO

CMD java -jar /opt/machine-history/machine-history-swarm.jar \
    -Dswarm.port.offset=${PORT_OFFSET} \
    -Dswarm.logging=${LOGGING_LEVEL}
