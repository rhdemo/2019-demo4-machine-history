FROM registry.access.redhat.com/ubi7-dev-preview/ubi-minimal
COPY target/machine-history-1.0-SNAPSHOT-runner runner
EXPOSE 8080
CMD ["./runner", "-Xmx10m", "-Xmn10m"]