FROM python:3.6-slim

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
      python-pip \
      python3-pip \
      ffmpeg \
      inotify-tools \
      curl \
  && \
  apt-get clean && \
  rm -rfv /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir deepspeech

WORKDIR /root

ADD https://github.com/mozilla/DeepSpeech/releases/download/v0.6.0/deepspeech-0.6.0-models.tar.gz /root

RUN \
  tar xvf deepspeech-0.6.0-models.tar.gz \
  && rm -v *.tar.gz \
  && useradd deep -u 1000 -s /bin/bash \
  && mkdir -pv /home/deep \
  && mv -v /root/deepspeech-0.6.0-models/ /home/deep/modelsEn/ \
  && chown -Rv deep:deep /home/deep

WORKDIR /home/deep
USER deep

ENTRYPOINT ["deepspeech"]
