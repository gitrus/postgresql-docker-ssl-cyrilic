FROM postgres:9.6

# localdef ru for postgresql cyrylic
# generate ssl-key for tls connections to postgresql
RUN apt-get update \
  && localedef -i ru_RU -c -f UTF-8 \
  -A /usr/share/locale/locale.alias ru_RU.UTF-8 \
  && apt-get install -y openssl \
  && openssl req -x509 -nodes -days 730 \
    -newkey rsa:2048 -keyout /etc/ssl/server.key \
    -out /etc/ssl/server.crt \
    -subj "/C=RU/ST=Moscow/L=Moscow/O=mi/OU=mi/CN=postgres" \
  && chown postgres /etc/ssl/server.key /etc/ssl/server.crt \
  && chmod 400 /etc/ssl/server.key /etc/ssl/server.crt

VOLUME /etc/postgresql

ENV LANG en_US.utf8
