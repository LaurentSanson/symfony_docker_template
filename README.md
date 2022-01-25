# Symfony Docker Template

A [Docker](https://www.docker.com/)-based [Symfony](https://symfony.com) template.

## Docker containers

1. PHP
2. MYSQL
3. NGINX
4. NODE (Uncomment it in docker-compose.yml only if needed. Eg: Once you have installed webpack-encore)
5. MAILDEV

## Getting Started

1. If not already done, [install Docker Compose](https://docs.docker.com/compose/install/)
2. Run `docker-compose build --pull --no-cache` to build fresh images
3. Run `docker-compose up -d`
5. Open `https://localhost` in your favorite web browser
6. Run `docker-compose down --remove-orphans` to stop the Docker containers.

## After containers started

Prefix all your commands with `./php`. Example : `./php php -v`

## Credits

Created by [Laurent Sanson](https://github.com/LaurentSanson/).