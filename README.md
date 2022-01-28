# Symfony Docker Template

A [Docker](https://www.docker.com/)-based [Symfony](https://symfony.com) template.

## Docker containers

1. PHP
2. MYSQL
3. NGINX
4. MAILDEV

## What's in there

1. A Symfony skeleton application
2. Symfony Flex
3. Annotations
4. Twig
5. Doctrine
6. Maker Bundle
7. PHP Unit, Paratest, Coverage-check and Dama Doctrine Bundle
8. PHPStan, PHP CS Fixer and Local PHP Security Checker
9. Webpack-Encore

## Getting Started

1. If not already done, [install Docker Compose](https://docs.docker.com/compose/install/)
2. Run `docker-compose build --pull --no-cache` to build fresh images
3. Run `docker-compose up -d`

## After containers started

1. Prefix all your commands with `./php`. Example : `./php php -v`

```bash
make install #Install the project
bin/console d:d:c #Create the database
bin/console d:m:m -n #Play the migrations (if there is any)
```

2. Open `https://localhost:8000` in your favorite web browser
3. Run `docker-compose down --volumes --remove-orphans` to stop the Docker containers.

Once you've added some code, you can delete the first line of the `make test` and uncomment the rest.

## Credits

Created by [Laurent Sanson](https://github.com/LaurentSanson/).
