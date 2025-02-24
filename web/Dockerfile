FROM php:8.4.4-apache-bullseye


RUN a2enmod rewrite
RUN mkdir -p /var/lib/php/sessions
RUN chown -R www-data:www-data /var/lib/php/sessions
RUN echo "session.save_path = /var/lib/php/sessions" >> /usr/local/etc/php/conf.d/session.ini
RUN docker-php-ext-install mysqli pdo pdo_mysql
COPY ./apache.conf /etc/apache2/sites-available/000-default.conf

# meglio caricare i file php con "volumes" (vedi compose.yml)
# ADD ./public /var/www/html
