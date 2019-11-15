FROM python:3.6-slim

RUN apt-get update
RUN apt-get install -y \
  python-pip \
  python3-pip \
  ffmpeg \
  inotify-tools \
  curl

RUN pip3 install deepspeech --user
WORKDIR /root

ADD https://github.com/mozilla/DeepSpeech/releases/download/v0.5.1/deepspeech-0.5.1-models.tar.gz /root
RUN tar xvf deepspeech-0.5.1-models.tar.gz
RUN rm *.tar.gz
RUN mv /root/deepspeech-0.5.1-models/ /root/modelsEn/

ENTRYPOINT ["deepspeech"]
