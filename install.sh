#!/usr/bin/env bash

set -e

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in
g_dotnvim_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Initializing plugin submodules..."
cd "${g_dotnvim_dir}"
git submodule update --init --recursive

echo "Installing YouCompleteMe..."
cd bundle/YouCompleteMe
python install.py --clang-completer
