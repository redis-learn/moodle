#!/bin/bash
/usr/local/bin/php ./install.php --wwwroot=http://127.0.0.1/moodle --dataroot=/data --dbtype='pgsql' --dbhost=$DB_HOST --dbname=moodle --dbuser=$DB_USER --dbpass=$DB_PASSWORD --fullname=RedisU --shortname=RedisU --adminpass=$MDL_PASSWORD --non-interactive --agree-license