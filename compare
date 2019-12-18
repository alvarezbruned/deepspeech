FROM python:3.6-slim

RUN apt-get update
RUN apt-get install -y \
  python-pip \
  python3-pip \
  ffmpeg \
  inotify-tools \
  curl

WORKDIR /root

ADD https://github.com/mozilla/DeepSpeech/releases/download/v0.6.0/deepspeech-0.6.0-models.tar.gz /root
RUN tar xvf deepspeech-0.6.0-models.tar.gz
RUN rm *.tar.gz

RUN useradd deep -u 1000 -s /bin/bash
RUN mkdir -p /home/deep
RUN mv /root/deepspeech-0.6.0-models/ /home/deep/modelsEn/

RUN chown deep -R /home/deep
WORKDIR /home/deep
USER deep

WORKDIR /home/deep
RUN pip3 install deepspeech --user
RUN ls -l /home/deep/.local/bin
ENTRYPOINT ["/home/deep/.local/bin/deepspeech"]
