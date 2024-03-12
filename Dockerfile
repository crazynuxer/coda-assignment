FROM ubuntu:22.04

RUN apt-get update
RUN apt-get -y install python3-pip \
    && pip install boto3
WORKDIR /opt
COPY download.py /opt/
CMD ["/usr/bin/python3 /opt/download.py"]
