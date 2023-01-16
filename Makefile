.DEFAULT_GOAL=help
project-name := Example

.PHONY: help

## —— Symfony 🎶 ———————————————————————————————————————————————————————————————
install: composer.lock.installed ## Install project

up:
	@docker-compose up -d

down:
	@docker-compose down --remove-orphans --volumes

build:
	@docker-compose build --pull --no-cache

composer.lock.installed:
	@./php composer install
	@./php yarn install
	@./php yarn build

composer-validate:
	@./php composer validate

php-cs-fixer:
	@./php ./vendor/bin/php-cs-fixer fix --diff --config=.php-cs-fixer.dist.php -v --dry-run --using-cache no --ansi

phpstan:
	@./php ./vendor/bin/phpstan analyze --memory-limit=-1 -l max --no-progress  ./src --ansi

security-checker:
	@./vendor/bin/security-checker --path=$$PWD

lint: composer-validate php-cs-fixer phpstan security-checker

cc: ## Clear the cache
	@./php bin/console c:c

cc-test: ## Clear the cache for test env
	@./php bin/console c:c --env=test

validate-schema:
	@./php php bin/console d:s:v --env=test

test: composer-validate## Run test suite
	@./php mkdir -p ./coverage
	@./php php -d xdebug.mode=coverage ./vendor/bin/paratest --coverage-html=./coverage --coverage-clover=./coverage/clover.xml
	@./php php -d xdebug.mode=coverage ./vendor/bin/coverage-check ./coverage/clover.xml 93
	@echo ---------------
	@echo file://$(shell pwd)/coverage/index.html
	@echo ---------------

clean:  ## Reset project to initial state
	@./php rm -rf vendor build composer.lock node_modules var public/assets

## —— Others 🛠️️ ———————————————————————————————————————————————————————————————
help: ## Liste des commandes
	@echo -e '\033[0;33m=================================\033[0m'
	@echo -e '\033[0;33m$(project-name)\033[0m'
	@echo -e '\033[0;33m=================================\033[0m'
	@echo
	@echo -e '\033[0;33mUsage: \033[0m'
	@echo '  make [target]'
	@echo
	@echo -e '\033[0;33mTargets: \033[0m'
	@grep  -hE '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m%-10s\033[0m %s\n", $$1, $$2}'
