#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/xeera/home.nix
popd
