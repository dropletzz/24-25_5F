FROM php:8.4-apache
RUN docker-php-ext-install mysqli pdo pdo_mysql

COPY ./apache.conf /etc/apache2/sites-available/000-default.conf

# meglio caricare i file php con "volumes" (vedi compose.yml)
# ADD ./public /var/www/html
