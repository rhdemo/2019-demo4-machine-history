FROM centos:7
RUN yum update -y
COPY target/machine-history-1.0-SNAPSHOT-runner runner
EXPOSE 8080
CMD ["./runner"]