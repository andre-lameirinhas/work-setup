.PHONY: setup
setup:
	./work-setup.sh

.PHONY: setup-skip-languages
setup-skip-languages:
	./work-setup.sh --skip-languages

.PHONY: test
test:
	./tests/test.sh

.PHONY: test-languages
test-languages:
	./tests/test-languages.sh

.PHONY: test-all
test-all: test test-languages

.PHONY: upgrade
upgrade:
	./scripts/brew-upgrader.sh

.PHONY: upgrade-log
upgrade-log:
	tail -50 ~/brew_upgrade.log
