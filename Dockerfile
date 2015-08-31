# Using CentOS base image to install an SSH server
# Version 1

# Pull the rhel image from the local repository
FROM centos:6.6
MAINTAINER Ken Evensen

USER root

RUN yum install -y openssh-server; yum clean all; rm -rf /var/cache/yum
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key; ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key; 
RUN useradd sshuser; mkdir -p /home/sshuser/.ssh; echo "sshuser:sshuser" | chpasswd
RUN chown -R sshuser:sshuser /home/sshuser/.ssh; chmod 700 /home/sshuser/.ssh; chmod +s /usr/sbin/sshd
ADD sshd_config /etc/ssh/
EXPOSE 22
USER sshuser
CMD ["/usr/sbin/sshd", "-D"]
