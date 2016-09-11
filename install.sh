#!/usr/bin/env bash

set -e

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in
g_dotvim_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Initializing plugin submodules..."
cd "${g_dotvim_dir}"
git submodule update --init --recursive

echo "Installing YouCompleteMe..."
cd bundle/YouCompleteMe
python install.py --clang-completer

echo "Creating links for .vimrc and .ycm_extra_conf.py in ${HOME}"
ln --symbolic "${g_dotvim_dir}/.vimrc" "${HOME}/.virmc"
ln --symbolic "${g_dotvim_dir}/.ycm_extra_conf.py" "${HOME}/.ycm_extra_conf.py"
