#!/usr/bin/env bash

# sometimes treesitter version is pinned to an outdated version for my needs.

cd /Users/jack/.local/share/lunarvim/site/pack/lazy/opt/nvim-treesitter
git checkout master
git pull --ff-only


cd /Users/jack/.local/share/lunarvim/site/pack/lazy/opt/nvim-treesitter-context
git checkout master
git pull --ff-only
