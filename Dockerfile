FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y openssh-server

RUN useradd remote_user && \
    echo "remote_user:1234" | chpasswd && \
    mkdir -p /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

COPY remote_key.pub /home/remote_user/.ssh/authorized_keys

RUN chown remote_user:remote_user -R /home/remote_user/.ssh/ && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

RUN ssh-keygen -A
RUN mkdir -p /var/run/sshd

CMD ["/usr/sbin/sshd","-D"]
