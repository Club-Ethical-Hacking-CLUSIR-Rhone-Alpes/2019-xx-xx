FROM ubuntu:18.04
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get install -yq openssh-server sudo lua5.3
RUN mkdir /var/run/sshd
RUN echo 'root:qf8stEHthk0Up5YBD' | chpasswd
RUN useradd -m -d /home/igor igor -s /usr/bin/lua5.3
RUN echo "igor:Zh1v0yPut1n" | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin no/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh
RUN echo "root ALL=(ALL) ALL" > /etc/sudoers && \
    echo "igor ALL = (root) NOPASSWD: /usr/bin/free" >> /etc/sudoers && \
    echo "igor ALL = (root) NOPASSWD: /usr/bin/clear" >> /etc/sudoers && \
    echo "igor ALL = (root) NOPASSWD: /usr/bin/find" >> /etc/sudoers && \
    echo "igor ALL = (root) NOPASSWD: /bin/ls" >> /etc/sudoers && \
    echo "igor ALL = (root) NOPASSWD: /usr/bin/users" >> /etc/sudoers && \
    echo "igor ALL = (root) NOPASSWD: /usr/bin/locale" >> /etc/sudoers && \
    echo "igor ALL = (root) NOPASSWD: /bin/mkdir" >> /etc/sudoers && \
    echo "igor ALL = (root) NOPASSWD: /usr/bin/who" >> /etc/sudoers && \
    echo "igor ALL = (root) NOPASSWD: /usr/bin/w" >> /etc/sudoers && \
    echo "igor ALL = (root) NOPASSWD: /usr/bin/arch" >> /etc/sudoers && \
    echo "" >> /etc/sudoers
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo '${CEH_LePythonDeLaFournaise}' > /root/flag
RUN echo '${CEH_LuaCarteSortieDePrison}' > /home/igor/flag && \
    echo "another flag has been set to /root/flag" >> /home/igor/flag && \
    chmod 777 /home/igor/flag
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]