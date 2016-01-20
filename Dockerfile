FROM cnam/protoc

RUN apt-get update && apt-get install -y gcc ruby-dev ruby git php5 php5-dev \
    && cd /usr/local/bin && curl -sS https://getcomposer.org/installer | php && mv composer.phar composer \
    && cd / && git clone https://github.com/grpc/grpc.git \
    && cd /grpc/src/php && composer install \
    && cd vendor/datto/protobuf-php \
    && gem install rake ronn \
    && rake pear:package version=1.0 \
    && pear install Protobuf-1.0.tgz

WORKDIR /data

VOLUME ["/data"]

ENTRYPOINT ["protoc-gen-php", "-i", "/data"]
