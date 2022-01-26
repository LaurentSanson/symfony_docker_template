.DEFAULT_GOAL=help
project-name := Template

.PHONY: help

## —— Symfony 🎶 ———————————————————————————————————————————————————————————————
install: composer.lock.installed ## Install project

composer.lock.installed:
	composer install

composer-validate:
	composer validate

php-cs-fixer:
	./vendor/bin/php-cs-fixer fix --diff --config=.php-cs-fixer.dist.php -v --dry-run --using-cache no --ansi

phpstan:
	./vendor/bin/phpstan analyze -l max --no-progress  ./src --ansi

security-checker:
	./vendor/bin/security-checker --path=$$PWD

lint: composer.lock.installed composer-validate php-cs-fixer phpstan security-checker

test: composer.lock.installed ## Run test suite
	php -d xdebug.default_enable=0 -d pcov.enabled=1 ./vendor/bin/paratest --coverage-html ./build/coverage --coverage-clover ./build/clover.xml --log-junit ./build/testreport.xml || true
	vendor/bin/coverage-check build/clover.xml 90

clean:  ## Reset project to initial state
	@rm -rf vendor build composer.lock node_modules var public/assets

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

