FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y openssh-server sudo vim
RUN mkdir /var/run/sshd
RUN echo 'root:rmEBx42homEBx42lTqohoh' | chpasswd
RUN useradd -m -d /home/pvexuser3ro pvexuser3ro -s /bin/bash
RUN echo "pvexuser3ro:J3Sape1R00t" | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin no/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh
RUN echo "root ALL=(ALL) ALL" > /etc/sudoers && \
    echo "pvexuser3ro ALL = (root) NOPASSWD: /usr/bin/vim" >> /etc/sudoers && \
    echo "" >> /etc/sudoers
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo '${EHC_ChampionDuSudo}' > /root/flag
RUN echo "real flag has been move to /root" > /home/pvexuser3ro/flag && \
    chmod 777 /home/pvexuser3ro/flag
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]