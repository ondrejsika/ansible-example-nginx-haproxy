#!/bin/sh

export PIPENV_IGNORE_VIRTUALENVS=1

PLAYBOOK=${1?Playbook is required as first argument}

pipenv run ansible-playbook -i inventory.yml $PLAYBOOK
