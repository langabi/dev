test: deps
	php -c test/etc/php.ini vendor/bin/peridot

coverage: deps
	phpdbg -c test/etc/php.ini -qrr vendor/bin/peridot --reporter html-code-coverage --code-coverage-path=artifacts/tests/coverage

lint: $(shell find src)
	composer validate
	vendor/bin/php-cs-fixer fix
ifndef TRAVIS
	travis lint
endif

deps: vendor

prepare: deps lint coverage

ci: lint
	phpdbg -c test/etc/php.ini -qrr vendor/bin/peridot --reporter clover-code-coverage --code-coverage-path=artifacts/tests/coverage/clover.xml

.PHONY: FORCE test coverage lint deps prepare ci

vendor: composer.lock
	composer install

composer.lock: composer.json
	composer update

src/%.php: FORCE
	@php -l $@ > /dev/null
