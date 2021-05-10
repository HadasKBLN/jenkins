FROM jenkins/jenkins:2.60.2

#install docker
USER root
RUN apt-get update && apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
  && curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > \
    /tmp/dkey; apt-key add /tmp/dkey \
  && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable" \
  && apt-get update && apt-get -y install \
    docker-ce=${docker_version}

ENV UID_JENKINS=1000
ENV GID_JENKINS=1000

COPY docker-entrypoint.sh /docker-entrypoint.sh




# RUN echo "root:pass" | chpasswd
# RUN apt-get update && apt-get install -y python3-pip && apt-get install -y jq
# RUN apt-get update
# RUN curl -sSL https://get.docker.com/ | sh
# RUN usermod -aG docker jenkins
# ENV DOCKER_HOST unix:///var/run/docker.sock

#install gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates gnupg
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install -y google-cloud-sdk
RUN apt-get install -y google-cloud-sdk-app-engine-java

# USER jenkins

ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]