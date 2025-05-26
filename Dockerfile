FROM ubuntu:latest

SHELL ["/bin/bash", "-exo", "pipefail", "-c"]

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    #composer \
    php \
    vim \
    curl \
    telnet \
    openssh-client \
    x11-apps \
    #build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY index.php /var/www

EXPOSE 8000

WORKDIR /var/www

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
