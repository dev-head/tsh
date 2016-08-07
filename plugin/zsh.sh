#!/bin/sh

ZSH_FILE=~/.zshrc

if [[ -f $ZSH_FILE ]]; then
    autoload zsh
fi