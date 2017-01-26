# Docker atom on Centos7

This repository contains a centos7 installation with atom running as the main process.

To run execute the following:
      
      docker run -d \  
        -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
        -e DISPLAY=unix${DISPLAY} \
        docker.io/hvindin/centos7-atom:latest
