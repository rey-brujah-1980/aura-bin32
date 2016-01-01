#!/usr/bin/bash

git clone http://github.com/aurapm/aura/
cd aura
git checkout aura-1.4

stack setup
stack install cabal-install
stack solver --modify-stack-yaml
stack build
