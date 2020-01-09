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
  rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir deepspeech

WORKDIR /root

RUN \
  curl --fail --location --show-error --silent --output /tmp/models.tar.gz \
    https://github.com/mozilla/DeepSpeech/releases/download/v0.6.0/deepspeech-0.6.0-models.tar.gz \
  && \
  tar xvf /tmp/models.tar.gz && \
  rm -v /tmp/models.tar.gz && \
  mkdir -pv /home/deep && \
  ls -lsa  /tmp && \
  ls -lsa  /root && \
  mv -v /root/deepspeech-0.6.0-models/ /home/deep/modelsEn/ \
  && \
  useradd deep -u 1000 -s /bin/bash \
  && chown -Rv deep:deep /home/deep

WORKDIR /home/deep
USER deep

ENTRYPOINT ["deepspeech"]
