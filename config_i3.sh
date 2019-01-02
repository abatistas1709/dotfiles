#!/bin/sh

rm -rfv ~/.config/i3
stow -v -t ~/.config/ config/
