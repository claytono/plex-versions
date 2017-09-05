test: test-python test-bash

test-bash:
	find . -path ./venv -prune -o -name '*.sh' -print0|xargs -0 bashate -v
	find . -path ./venv -prune -o -name '*.sh' -print0|xargs -0 shellcheck
test-python:
	find . -path ./venv -prune -o -name '*.py' -print0|xargs -0 pylint
