setup:
	./work-setup.sh

test:
	./tests/test.sh

upgrade:
	./scripts/brew-upgrader.sh

upgrade-log:
	tail -50 ~/brew_upgrade.log
