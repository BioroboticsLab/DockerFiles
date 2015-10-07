# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node. 

FROM ubuntu:15.04
MAINTAINER Michael Wittig <witmic1@gmail.com> 

#RUN sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
ENV DEBIAN_FRONTEND noninteractive

# Make sure the package repository is up to date. RUN apt-get update
RUN apt-get -y update && apt-get -y upgrade

# Install a basic SSH server 
RUN apt-get install -y openssh-server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Install JDK 7 (latest edition) 
RUN apt-get install -y --force-yes tzdata=2015c-1
RUN apt-get install -y openjdk-7-jdk

#install supervisor
#RUN apt-get install -y supervisor
#RUN mkdir -p /var/log/supervisor
#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add user jenkins to the image 
RUN useradd -m jenkins

# Set random passwords for the root and jenkins users. 
RUN echo "root:$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32)" | chpasswd  
RUN echo "jenkins:$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 32)" | chpasswd

# Add jenkins SSH pubkey to authorized_keys
RUN mkdir -p /home/jenkins/.ssh
RUN mkdir -p /root/.ssh

RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/4M6G+wnzZFaxio8EVRhKXz/RMa1e0hh2eZeE5Da4S9pQnR7zcZNa90bpqHA9GOUfrYMoLOYXoQp5iKq/WzTzhQmVe6mxxuJMUWCQC1Ne2BMB3OkYjGeOeM4bRzFbM1SVxYAumoncdRB/77FN6D1EYgBWTr0ySRQOy3AbH5wMSb2ZKnhrd4W5JMqAxqyrSCoFUlXzD9gMeHzFhOoUItMh62U6CYPAErRDLPaFqjVOR9thzpfYl5xQ3xrS0ldmY8wL3u7mtMHG5wPt2xV4mfyHUqGlONpBKINPH4qKtJ3qsxdyaR0tvxCy8cbEEJLnfJFQcOg88E9X6M2NWVdNks/v jenkins@flip" >> /home/jenkins/.ssh/authorized_keys

RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/4M6G+wnzZFaxio8EVRhKXz/RMa1e0hh2eZeE5Da4S9pQnR7zcZNa90bpqHA9GOUfrYMoLOYXoQp5iKq/WzTzhQmVe6mxxuJMUWCQC1Ne2BMB3OkYjGeOeM4bRzFbM1SVxYAumoncdRB/77FN6D1EYgBWTr0ySRQOy3AbH5wMSb2ZKnhrd4W5JMqAxqyrSCoFUlXzD9gMeHzFhOoUItMh62U6CYPAErRDLPaFqjVOR9thzpfYl5xQ3xrS0ldmY8wL3u7mtMHG5wPt2xV4mfyHUqGlONpBKINPH4qKtJ3qsxdyaR0tvxCy8cbEEJLnfJFQcOg88E9X6M2NWVdNks/v jenkins@flip" >> /root/.ssh/authorized_keys

RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCoNopTUl0Fb6EtHV68YMhdrN/pQg5zY6tZ1QtmsHdqROVt2ahQ3XRd3zaHJih1VUBpU+c+LCUVwcpsnZ2hVJh3yVZVVb3iugovYVWt0qaoBMAu/mjCkDRmwF82SWnlsLCJDM64HHE3dkND2GjZf7FJGSUjhPocryriJ2jpACjiWYxWEF0xDmuFDK7B7030lODKtu1F7Ie4wMalwMZ0YxcWtoqu7lqa0MwMFbaY64RdhIjXykDDsEM50scrNqO1SUyH027HSKIp/y5barOueSZD2tyDQV6XaXT1v/d4MD1F1jO09AtzgDAsNfkcOcFeOOZuM914DC7egxyWmYZbEto7 sh4ke@michael-TP" >> /home/jenkins/.ssh/authorized_keys

RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCoNopTUl0Fb6EtHV68YMhdrN/pQg5zY6tZ1QtmsHdqROVt2ahQ3XRd3zaHJih1VUBpU+c+LCUVwcpsnZ2hVJh3yVZVVb3iugovYVWt0qaoBMAu/mjCkDRmwF82SWnlsLCJDM64HHE3dkND2GjZf7FJGSUjhPocryriJ2jpACjiWYxWEF0xDmuFDK7B7030lODKtu1F7Ie4wMalwMZ0YxcWtoqu7lqa0MwMFbaY64RdhIjXykDDsEM50scrNqO1SUyH027HSKIp/y5barOueSZD2tyDQV6XaXT1v/d4MD1F1jO09AtzgDAsNfkcOcFeOOZuM914DC7egxyWmYZbEto7 sh4ke@michael-TP" >> /root/.ssh/authorized_keys

# Start sshd and export Standard SSH port 
EXPOSE 22 
CMD ["/usr/sbin/sshd", "-D"]
#CMD ["/usr/bin/supervisord"]
