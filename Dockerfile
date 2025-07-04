FROM debian:latest

ARG DEBIAN_FRONTEND=noninteractive
ARG VERSION_OVERRIDE

RUN apt-get -qq update \
      && apt-get -qq -y install ca-certificates wget sudo \
      && wget -O install-site.sh --no-verbose https://raw.githubusercontent.com/mysociety/commonlib/master/bin/install-site.sh \
      && chmod +x /install-site.sh \
      && echo 'fms ALL=(ALL) NOPASSWD: /var/www/fixmystreet/fixmystreet/bin/install_packages' \
         >/etc/sudoers.d/10_fms_install_packages \
      && chmod 0440 /etc/sudoers.d/10_fms_install_packages

RUN /install-site.sh --docker fixmystreet fms 127.0.0.1.xip.io \
      && apt-get purge -y --auto-remove \
        make \
        g++ \
        libexpat1-dev \
        libssl-dev \
        zlib1g-dev \
        libxml2-dev \
        postgresql-server-dev-all \
        exim4-daemon-light \
      && apt-get -y clean \
      && rm -fr /var/lib/apt/lists/* \
      && rm -fr /home/fms/.cpanm/*

RUN cp /var/www/fixmystreet/fixmystreet/bin/docker.preinit /usr/local/preinit/99-fixmystreet \
      && chmod +x /usr/local/preinit/99-fixmystreet

EXPOSE 9000
CMD ["/usr/local/bin/boot-debian-base"]
