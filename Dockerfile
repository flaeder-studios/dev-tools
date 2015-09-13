FROM ubuntu:trusty

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/sublime-text-3
RUN apt-get update && apt-get -y install sublime-text libglib2.0-dev libx11-dev libgtk2.0-0 dbus

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

ADD start.sh /home/developer/
RUN chmod a+x /home/developer/start.sh
RUN chown ${uid}:${gid} /home/developer/start.sh

USER developer
ENV HOME /home/developer
