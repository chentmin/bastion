FROM scratch
ADD rootfs.tar.gz /
RUN apk --update add openssh
RUN ssh-keygen -A
RUN echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
  echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
  echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config && \
  echo "Port 9022" >> /etc/ssh/sshd_config

RUN adduser -D dev && passwd -d dev && mkdir /home/dev/.ssh && chown dev:nogroup /home/dev/.ssh && chmod 700 /home/dev/.ssh
ADD harden.sh /harden.sh
RUN chmod 700 /harden.sh && /harden.sh && rm /harden.sh
USER dev
CMD ["/usr/sbin/sshd", "-D"]
