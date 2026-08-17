.PHONY: setup
setup:
	./work-setup.sh

.PHONY: setup-skip-languages
setup-skip-languages:
	./work-setup.sh --skip-languages

.PHONY: lint
lint:
	@for f in *.sh scripts/*.sh tests/*.sh; do zsh -n "$$f" || exit 1; echo "OK: $$f"; done

.PHONY: test
test: lint
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
