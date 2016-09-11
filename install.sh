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

g_vimrc=".vimrc"
g_ycm_conf=".ycm_extra_conf.py"

g_config_files=($g_vimrc $g_ycm_conf)
for filename in "${g_config_files[@]}"
do
    echo "Installing $filename..."
    ln -s "${g_dotvim_dir}/$filename" "${HOME}/$filename"
done
