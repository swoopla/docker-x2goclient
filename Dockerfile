FROM ubuntu:bionic as GPG_KEY

LABEL maintainer "Swoopla <p.vibet@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:x2go/stable

FROM ubuntu:bionic

LABEL maintainer "Swoopla <p.vibet@gmail.com>"

COPY --from=GPG_KEY /etc/apt/trusted.gpg.d/x2go_ubuntu_stable.gpg /etc/apt/trusted.gpg.d/

COPY --from=GPG_KEY /etc/apt/sources.list.d/x2go-ubuntu-stable-bionic.list /etc/apt/sources.list.d/

RUN apt-get update && \
    apt-get -y install x2goclient openssh-sftp-server openssh-server --no-install-recommends && \
    rm -rf /var/lib/lists/*

RUN adduser --disabled-password --gecos swoopla swoopla

USER swoopla

ENV USER=swoopla \
    DISPLAY=:0.0 \
    SSH_AUTH_SOCK=/run/user/1000/keyring/ssh

VOLUME ["/home/swoopla/.x2goclient","/tmp/.X11-unix","/run/user/1000/keyring/ssh"]

CMD ["x2goclient"]
