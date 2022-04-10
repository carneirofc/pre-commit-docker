#!/bin/sh
if [ ! -f /pre-commit/.pre-commit-config.yaml ]; then
cat << EOF > /pre-commit/.pre-commit-config.yaml
repos:
-   repo: https://github.com/pre-commit/pre-commit-hooks
    rev: /pre-commit-hooks
    hooks:
    -   id: trailing-whitespace
    -   id: end-of-file-fixer
    -   id: check-yaml
    -   id: check-json
    -   id: debug-statements
    -   id: double-quote-string-fixer
    -   id: name-tests-test
    -   id: requirements-txt-fixer
    -   id: mixed-line-ending
EOF
fi

if [ ! -d .git/ ]; then
echo "Git repo not found"
fi

pre-commit run --all-files .