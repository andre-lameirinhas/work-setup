#!/bin/zsh

# colors
Red="\033[0;31m"
Green="\033[0;32m"
NC="\033[0m"

source ~/.zshrc

FAILURES=0

pass () {
    echo "$1 ${Green}passed${NC}"
}

fail () {
    echo "$1 ${Red}failed${NC}"
    FAILURES=$((FAILURES + 1))
}

check () {
    local desc=$1
    shift
    if "$@" >/dev/null 2>&1; then
        pass "$desc"
    else
        fail "$desc"
    fi
}

check "claude" claude --version
check "jq" jq --version
check "rtk" rtk --version
[ -s ~/.claude/statusline-command.sh ] && pass "claude statusline script" || fail "claude statusline script"
grep -q "statusLine" ~/.claude/settings.json && pass "claude statusline config" || fail "claude statusline config"

if [[ $FAILURES -gt 0 ]]; then
    echo "${Red}${FAILURES} test(s) failed${NC}"
    exit 1
else
    echo "${Green}All claude tests have passed!${NC}"
fi
