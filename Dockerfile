FROM ubuntu:trusty

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/sublime-text-3
RUN apt-get update && apt-get -y install \
	build-essential \
	cmake \
	curl \
	git \
	libglib2.0-dev \
	libgtk2.0-0 \
	libx11-dev \
	make \
	sublime-text \
	xterm \
	libboost1.55-all-dev \
        doxygen \
        openssl


# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

# Set the locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

# Fix github access
ADD repo-key /home/developer/
RUN chmod 600 /home/developer/repo-key
RUN echo "IdentityFile /home/developer/repo-key" >> /etc/ssh/ssh_config
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

# install netlib
RUN git clone git://github.com/cpp-netlib/cpp-netlib.git && cd cpp-netlib && git submodule init && git submodule update
RUN mkdir cpp-netlib/build && cd cpp-netlib/build && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ ..
RUN cd cpp-netlib/build && make && make test && make install

# Add start scripts
ADD start.sh /home/developer/
RUN chmod a+x /home/developer/start.sh
RUN chown ${uid}:${gid} /home/developer/start.sh

USER developer
