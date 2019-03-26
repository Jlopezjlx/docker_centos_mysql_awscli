FROM centos

RUN yum install -y openssh-server

RUN useradd jlopez && \
    echo "1234"| passwd jlopez --stdin && \
    mkdir /home/jlopez/.ssh && \
    chmod 700 /home/jlopez/.ssh

COPY key.pub /home/jlopez/.ssh/authorized_keys

RUN chown jlopez:jlopez -R /home/jlopez/.ssh/authorized_keys/ && \
    chmod 600 /home/jlopez/.ssh/authorized_keys/

RUN /usr/sbin/sshd-keygen

RUN yum -y install mysql

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    pip3 install awscli

CMD /usr/sbin/sshd -D
