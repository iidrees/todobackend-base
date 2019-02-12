FROM ubuntu:trusty

# prevent dpkg errors
ENV TERM=xterm-256color

# set mirrors to NZ
RUN sed -i "s/http:\/\/archive./http:\/\/nz.archive./g" /etc/apt/sources.list
 
#  Install python runtime
RUN apt-get update && \
    apt-get install -qy \
    -o APT::Install-Recommend=false -o APT::Install-Suggests=false \
    python3 python-virtualenv 


RUN apt-get update -y && \
  apt-get install -y python3-pip python3-dev python3 zlib1g-dev libbz2-dev && \
  apt-get install build-essential -y && \
  apt-get install libssl-dev -y && \
  apt-get install python-mysqldb -y && \
  pip3 install virtualenv 
  # python3 python-virtualenv
  # sudo apt install virtualenv
  # apt-get install python-3-venv

RUN virtualenv /appenv && \ 
    . /appenv/bin/activate && \
    pip3 install pip --upgrade

#  Add entrypoint script
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]

LABEL application="todobackend"