FROM jupyterhub/jupyterhub:latest

MAINTAINER @diegopereyra977

ARG USER
ARG PASSWD

RUN apt -y update && \
    apt -y upgrade && \
    apt -y install openjdk-11-jdk && \
    apt -y install expect && \
    apt -y install zip unzip && \
    apt purge && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN conda install -y jupyter
RUN wget https://github.com/SpencerPark/IJava/releases/download/v1.2.0/ijava-1.2.0.zip
RUN unzip ijava-1.2.0.zip
RUN python install.py


COPY jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py
COPY myautopasswd /srv/jupyterhub/myautopasswd

RUN ./myautopasswd $USER $PASSWD
