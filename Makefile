.PHONY: setup
setup:
	./work-setup.sh

.PHONY: test
test:
	./tests/test.sh

.PHONY: upgrade
upgrade:
	./scripts/brew-upgrader.sh

.PHONY: upgrade-log
upgrade-log:
	tail -50 ~/brew_upgrade.log
