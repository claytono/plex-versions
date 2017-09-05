test: test-bash

test-bash:
	find . -path ./venv -prune -o -name '*.sh' -print0|xargs -0 bashate -v
	find . -path ./venv -prune -o -name '*.sh' -print0|xargs -0 shellcheck
