
brew-upgrade:
	./scripts/brew-upgrader.sh

brew-upgrade-log:
	tail -50 ~/brew_upgrade.log

test:
	./tests/test.sh

work-setup:
	./work-setup.sh --dry-run

