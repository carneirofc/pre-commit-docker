#!/bin/sh
function run {
    pre-commit run --all-files --verbose --show-diff-on-failure
    pre-commit uninstall
}

function run_default {
    cat << EOF > /pre-commit/.pre-commit-config.yaml
repos:
- repo: /pre-commit-hooks
  rev: ${PRE_COMMIT_HOOKS_VERSION}
  hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-json
      - id: mixed-line-ending
EOF
    run
    rm /pre-commit/.pre-commit-config.yaml
}

if [ ! -z "$@" ]; then
    $@
else
    if [ ! -f /pre-commit/.pre-commit-config.yaml ]; then
        run_default
    else
        run
    fi
fi
