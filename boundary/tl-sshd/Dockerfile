FROM tl-ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y unzip wget openssh-server

RUN mkdir /var/run/sshd

# change this!!
RUN echo 'ubuntu:your_password' | chpasswd

# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

CMD ["/usr/sbin/sshd", "-D"]