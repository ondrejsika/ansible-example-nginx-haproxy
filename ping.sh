#!/bin/sh

export PIPENV_IGNORE_VIRTUALENVS=1

HOSTS=${1:-all}

pipenv run ansible -i inventory.yml $HOSTS -m ping
