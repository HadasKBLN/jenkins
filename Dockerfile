FROM jenkins/jenkins:2.277.4-jdk11

#install docker
USER root
RUN echo "root:pass" | chpasswd
RUN apt-get update && apt-get install -y python3-pip && apt-get install -y jq
RUN curl -sSL https://get.docker.com/ | sh
RUN usermod -aG docker jenkins
ENV DOCKER_HOST unix:///var/run/docker.sock

#install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)"  -o /usr/local/bin/docker-compose
RUN mv /usr/local/bin/docker-compose /usr/bin/docker-compose
RUN chmod +x /usr/bin/docker-compose

#install gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y
RUN usermod -a -G docker root


USER jenkins