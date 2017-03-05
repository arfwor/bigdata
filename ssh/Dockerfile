FROM basic-hadoop

RUN apt -y install ssh
RUN echo "/usr/sbin/sshd" >> ~/.bashrc

RUN ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN echo "StrictHostKeyChecking no" >> ~/.ssh/config

RUN mkdir /var/run/sshd
