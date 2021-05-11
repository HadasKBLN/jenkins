FROM jenkins/jenkins:2.277.4-lts-jdk11

#install docker
USER root
RUN echo "root:pass" | chpasswd
RUN apt-get update && apt-get install -y python3-pip && apt-get install -y jq
RUN curl -sSL https://get.docker.com/ | sh
RUN usermod -aG docker jenkins
ENV DOCKER_HOST unix:///var/run/docker.sock

#install gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN mv /etc/apt/trusted.gpg.d/ /etc/apt/trusted.gpg.d.backup
RUN mkdir /etc/apt/trusted.gpg.d
RUN chmod 755 /etc/apt/trusted.gpg.d
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B57C5C2836F4BEB
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FEEA9169307EA071
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DCC9EFBF77E11517
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AA8E81B4331F7F50
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 112695A0E562B32A

RUN apt-get update && apt-get install -y apt-transport-https ca-certificates gnupg
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install -y google-cloud-sdk
RUN apt-get install -y google-cloud-sdk-app-engine-java

USER jenkins