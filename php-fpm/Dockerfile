FROM krallin/ubuntu-tini:xenial
ARG PHPVERSION="7.2"
################################################ DOCKER BASE ########################################
# Apuntamos al Mirror chile
#RUN sed -i 's/http:\/\/archive/http:\/\/cl\.archive/g' /etc/apt/sources.list && apt-get update
RUN apt-get update

# Instalar Repositorios PHP
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends software-properties-common curl locales
RUN DEBIAN_FRONTEND=noninteractive LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C

# Instalar PHP
RUN apt-get update && apt-get -y install --no-install-recommends php$PHPVERSION-mysql php$PHPVERSION-curl php$PHPVERSION-xml \
php$PHPVERSION-bcmath php$PHPVERSION-gd php$PHPVERSION-mbstring  php$PHPVERSION-zip php$PHPVERSION-ssh2 php$PHPVERSION-fpm php$PHPVERSION-intl  \
apt-transport-https ca-certificates build-essential php$PHPVERSION-xdebug bash-completion
#Instalar Nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN bash nodesource_setup.sh
RUN apt install -y nodejs build-essential yarn
# Composer Install
ENV COMPOSER_ALLOW_SUPERUSER=1 SERVER_TYPE=SLAVE TZ=America/Santiago

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
       composer global require hirak/prestissimo

#Servidor Web
RUN apt-get update && apt-get -y install nginx vim git poppler-utils && mkdir -p /run/php/

ADD files/startup.sh /opt/startup.sh
ADD files/nginx.conf /etc/nginx/nginx.conf
ADD files/www.conf /etc/php/7.2/fpm/pool.d/www.conf
ADD files/xdebug.ini /etc/php/7.2/mods-available/xdebug.ini
ADD files/vhost_desarrollo.conf /etc/nginx/sites-enabled/default
#ADD docker/ssh /root/.ssh
#RUN chmod 600 /root/.ssh/*
RUN chmod +x /opt/startup.sh
CMD /opt/startup.sh


