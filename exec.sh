#!/bin/sh

export PIPENV_IGNORE_VIRTUALENVS=1

COMMAND=${1?Command is required as first argument}
HOSTS=${2:-all}

pipenv run ansible -i inventory.yml $HOSTS -a "$COMMAND"
