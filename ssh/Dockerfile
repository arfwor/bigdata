FROM basic-hadoop

RUN apt -y install ssh
RUN echo "/usr/sbin/sshd" >> /root/.bashrc

RUN ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN mkdir /var/run/sshd
