#!/bin/bash
# Bash wrappers for docker run commands

x2goclient(){
  del_stopped x2goclient

  xhost + 1>/dev/null 2>&1

  docker run -d \
      --rm \
      --name x2goclient \
      --device /dev/snd \
      --device /dev/dri \
      --net host \
      -e "DISPLAY=unix${DISPLAY}" \
      -e SSH_AUTH_SOCK=/run/user/1000/keyring/ssh \
      -u $USER \
      -v /etc/localtime:/etc/localtime:ro \
      -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
      -v "${HOME}/.x2goclient:/home/swoopla/.x2goclient" \
      -v /run/user/1000/keyring/ssh:/run/user/1000/keyring/ssh \
      swoopla/x2goclient "$@"

  # exit current shell
  exit 0
}
