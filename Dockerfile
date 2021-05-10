FROM jenkins/jenkins:2.60.2

#install docker
USER root
RUN echo "root:pass" | chpasswd
RUN apt-get update && apt-get install -y python3-pip && apt-get install -y jq
RUN apt-get update -y
RUN curl -fsSL https://get.docker.com -o get-docker.sh
# RUN curl -sSL https://get.docker.com/ | sh
RUN sh get-docker.sh
RUN usermod -aG docker jenkins
ENV DOCKER_HOST unix:///var/run/docker.sock

#install gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates gnupg
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install -y google-cloud-sdk
RUN apt-get install -y google-cloud-sdk-app-engine-java

USER jenkins