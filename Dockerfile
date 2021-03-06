FROM debian:jessie

MAINTAINER SuJianchao <sujianchao@gmail.com>

ENV REFRESHED_AT 2016-07-22

RUN apt-get update && apt-get install -y \
		wget \
		curl \
		cron \
		openssh-server \
		pwgen \
		dnsmasq \
		vim  \
	--no-install-recommends && rm -r /var/lib/apt/lists/*
	
RUN mkdir -p /var/run/sshd \
	&& sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
	&& sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config \
	&& sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

ENV AUTHORIZED_KEYS **None**
#ENV ROOT_PASS


#Configure password and dnsmasq
COPY conf/dnsmasq.conf /etc/dnsmasq.conf

#everyday update dnsmasq.conf
RUN echo "0 3 * * * rm -rvf /etc/dnsmasq.conf && wget --no-check-certificate -c -t 0 -b  -O /etc/dnsmasq.conf https://github.com/sujianchao/GoWorld/raw/master/dnsmasq.conf" >> /etc/crontab


ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22 53 53/udp

CMD ["/run.sh"]
