FROM python:3.6

ARG pip_installer="https://bootstrap.pypa.io/get-pip.py"
ARG awscli_version="1.16.168"

# install aws-cli
RUN pip install awscli==${awscli_version}

# install sam
RUN pip install --user --upgrade aws-sam-cli
ENV PATH $PATH:/root/.local/bin

# install command.
RUN apt-get update && apt-get install -y less vim wget unzip

# install terraform.
# https://azukipochette.hatenablog.com/entry/2018/06/24/004354
RUN wget https://releases.hashicorp.com/terraform/0.12.13/terraform_0.12.13_linux_amd64.zip && \
  unzip ./terraform_0.12.13_linux_amd64.zip -d /usr/local/bin/

# create workspace.
COPY ./docker/terraform/src /root/src

# initialize command.
ARG $AWS_ACCESS_KEY_ID
ARG $AWS_SECRET_ACCESS_KEY
COPY ./docker/terraform/.aws /root/.aws
COPY ./docker/terraform/init.sh /root/init.sh
RUN chmod +x /root/init.sh && /root/init.sh

WORKDIR /root/src
