FROM ubuntu:20.04

ENV STM32CUBEIDE_VERSION=1.8.0

ENV DEBIAN_FRONTEND=noninteractive

ENV LICENSE_ALREADY_ACCEPTED=1

ENV TZ=Etc/UTC

ENV PATH="${PATH}:/opt/st/stm32cubeide_${STM32CUBEIDE_VERSION}"

# STM Cube IDE Build Number
ARG BUILD="11526_20211125_0815"

RUN apt-get -y update && \
    apt-get -y install zip curl && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y pip

COPY requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

# This is sorta a work around for git lfs. Github actions doesn't clone the git lfs files by default
RUN gdown 196-UdzhZgfUZEKmr5JzYIM6HkaKGH3ln

RUN chmod +x ./st-stm32cubeide_${STM32CUBEIDE_VERSION}_${BUILD}_amd64.deb_bundle.sh \
    && ./st-stm32cubeide_${STM32CUBEIDE_VERSION}_${BUILD}_amd64.deb_bundle.sh \
    && rm ./st-stm32cubeide_${STM32CUBEIDE_VERSION}_${BUILD}_amd64.deb_bundle.sh
