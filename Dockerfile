FROM php:8.2.6-apache
WORKDIR /var/www/html

# Configure Apache
RUN echo 'AcceptPathInfo On' >> /etc/apache2/apache2.conf

# Install dependencies
RUN apt-get update; apt-get install wget
RUN apt-get install postgresql
RUN apt-get install libpq-dev

# Install Postgres driver to PHP
RUN docker-php-ext-install pgsql

# Download and extract Moodle
RUN wget https://download.moodle.org/download.php/direct/stable402/moodle-latest-402.tgz
RUN tar -xvf ./moodle-latest-402.tgz
RUN rm moodle-latest-402.tgz
RUN chown www-data ./moodle
RUN chmod -R 0755 ./moodle

# Ceate a data directory
# TODO: Should be a volume
RUN mkdir /data
RUN chown www-data /data

# Install Moodle
ARG WD=/var/www/html/moodle/admin/cli
WORKDIR ${WD}
COPY install.bash ${WD}

# TODO: Needs to be installed at runtime, not build time
RUN su - www-data $PWD/install.bash

EXPOSE 80
CMD ["service", "apache2", "start"]


