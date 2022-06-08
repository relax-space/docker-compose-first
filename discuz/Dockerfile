FROM k3rnelpan1c/alpine-wget as builder

ARG discuz_url=https://gitee.com/Discuz/DiscuzX/attach_files/1067409/download/Discuz_X3.4_SC_UTF8_20220518.zip
ARG tmp_discuz=/tmp/discuz
RUN wget -O $tmp_discuz.zip $discuz_url
RUN mkdir -p $tmp_discuz && unzip $tmp_discuz.zip -d $tmp_discuz
RUN sed -i \
    -e "s|127.0.0.1|mysql|g" \
    -e "s|localhost|mysql|g" \
    $tmp_discuz/upload/config/config_global_default.php

FROM php:7.4.29-apache

WORKDIR /var/www/html
COPY --from=builder /tmp/discuz/upload .
RUN docker-php-ext-install mysqli pdo_mysql exif \
    && apt-get update -y && apt-get install -y\
    libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev libfreetype6-dev  zlib1g-dev libzip-dev zip \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && a2enmod ssl \
    && a2enmod rewrite \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && chmod a+w -R config data uc_server/data uc_client/data \
&& for i in /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini-production; \
do \
    sed -i \
    -e "s|;extension=mysqli|extension=mysqli|g" \
    -e "s|;extension=pdo_mysql|extension=pdo_mysql|g" \
    -e "s|;extension=exif|extension=exif|g" \
    -e "s|;extension=fileinfo|extension=fileinfo|g" \
    -e "s|;extension=curl|extension=curl|g" \
    -e "s|;extension=gd2|extension=gd2|g" \
    -e "s|;extension=mbstring|extension=mbstring|g" \
    -e "s|;extension=openssl|extension=openssl|g" \
    -e "s|;exif.encode_unicode|exif.encode_unicode|g" \
    -e "s|;exif.decode_unicode_motorola|exif.decode_unicode_motorola|g" \
    -e "s|;exif.decode_unicode_intel|exif.decode_unicode_intel|g" \
    -e "s|;exif.encode_jis|exif.encode_jis|g" \
    -e "s|;exif.decode_jis_motorola|exif.decode_jis_motorola|g" \
    -e "s|;exif.decode_jis_intel|exif.decode_jis_intel|g" \
    -e "s|;opcache.log_verbosity_level=1|opcache.log_verbosity_level=0|g" \
    $i; \
done;
