FROM httpd:2.4

RUN apt-get -yq update && \
  apt-get upgrade -yq && \
  DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends \
  install \
    build-essential \
    ca-certificates \
    curl \
    gettext \
    libssl-dev \
    perl \
    zlib1g-dev \
  && apt-get -y clean && \
  rm -rf /var/lib/apt/lists/*

RUN curl -L https://cpanmin.us | perl - App::cpanminus

RUN cpanm --verbose \
  Authen::SASL \
  CGI \
  HTML::Parser \
  HTML::TagFilter \
  HTML::Tagset \
  IO::Socket::SSL \
  Net::SMTP \
  Net::SSLeay \
  URI::Escape

RUN sh -c '{ \
  printf "\nLoadModule cgi_module modules/mod_cgi.so"; \
  printf "\nLoadModule negotiation_module modules/mod_negotiation.so"; \
  printf "\nInclude conf/extra/httpd-languages.conf"; \
  printf "\nInclude conf/extra/civs.conf"; \
} >> /usr/local/apache2/conf/httpd.conf'

RUN sed "s|ScriptAlias\ \/cgi-bin\/|# ScriptAlias /cgi-bin/|" < /usr/local/apache2/conf/httpd.conf > /usr/local/apache2/conf/httpd-noscript.conf
RUN mv /usr/local/apache2/conf/httpd-noscript.conf /usr/local/apache2/conf/httpd.conf

COPY . /civs
RUN mkdir -p /data

RUN ln -sf /dev/stdout /data/log
RUN ln -sf /dev/stderr /data/log

WORKDIR /var/www/html
ENTRYPOINT ["/civs/docker/entrypoint.sh"]
CMD ["httpd-foreground"]
