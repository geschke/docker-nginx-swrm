# SPDX-License-Identifier: MIT
# Copyright (c) 2018-2026 Ralf Geschke

FROM ubuntu:resolute-20260421

LABEL org.opencontainers.image.authors="Ralf Geschke <ralf@kuerbis.org>"
LABEL org.opencontainers.image.licenses="MIT"

LABEL maintainer="Ralf Geschke <ralf@kuerbis.org>"
LABEL last_changed="2026-05-10"

# Install current updates & Nginx
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get -y upgrade \
    && apt-get -y dist-upgrade \
    && apt-get install -y ca-certificates locales \
    && sed -i 's/^# *\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8 \
    && apt-get install -y --no-install-recommends nginx publicsuffix curl libfcgi-bin \
    && rm -rf /var/lib/apt/lists/*


ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

WORKDIR /var/www/html

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

