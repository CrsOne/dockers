FROM krallin/ubuntu-tini:xenial
#USAMOS TINI como imagen base que es algo que soluciona el problema de los procesos zoombies y hace signal forwarding https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/

# Apuntamos al Mirror chile
RUN sed -i 's/http:\/\/archive/http:\/\/cl\.archive/g' /etc/apt/sources.list && apt-get update
RUN apt-get update

# Instalar Repositorios PHP
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends software-properties-common curl locales
RUN DEBIAN_FRONTEND=noninteractive LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C

# Instalar PHP
RUN apt-get update && apt-get -y install --no-install-recommends php7.1-mysql php7.1-curl php7.1-xml php7.1-bcmath php7.1-gd php7.1-mbstring php7.1-mcrypt php7.1-zip php7.1-ssh2 php7.1-fpm php7.1-intl php7.1-xdebug bash-completion


# Composer Install
ENV COMPOSER_ALLOW_SUPERUSER=1 SERVER_TYPE=SLAVE TZ=America/Santiago

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
       composer global require hirak/prestissimo

#Servidor Web
RUN apt-get update && apt-get -y install nginx vim git poppler-utils && mkdir -p /run/php/

RUN mkdir -p /opt/develop/

ADD files/startup.sh /opt/startup.sh
ADD files/nginx.conf /etc/nginx/nginx.conf
ADD files/www.conf /etc/php/7.1/fpm/pool.d/www.conf
ADD files/xdebug.ini /etc/php/7.1/mods-available/xdebug.ini
ADD files/vhost_desarrollo.conf /etc/nginx/sites-enabled/default
#ADD docker/ssh /root/.ssh
#RUN chmod 600 /root/.ssh/*
RUN chmod +x /opt/startup.sh
CMD /opt/startup.sh


