#!/usr/bin/env bash
#
# Script to install the required packages and do the required setup for my Vim
# environment to work properly.
# Target environment is Ubuntu 14.04 LTS

set -e

################################################################################
# Globals
################################################################################

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in
g_dotvim_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

g_tmp_dir='/tmp/vim_env_install_work'
g_nagelfar_release='123'
g_profile_name='vim-solarized'

################################################################################
# Functions
################################################################################

function install_nagelfar()
{
    local pkg="nagelfar${g_nagelfar_release}"
    local install_dir="/opt/${pkg}"
    local nag_exe="nagelfar.tcl"
    local nag_symlink="/usr/local/bin/${nag_exe}"

    echo "Downloading ${pkg}"
    wget "https://sourceforge.net/projects/nagelfar/files/Rel_${g_nagelfar_release}/${pkg}.tar.gz" -P "${g_tmp_dir}/${pkg}"

    echo "Unpacking ${pkg}"
    tar -zxvf "${g_tmp_dir}/${pkg}.tar.gz"

    echo "Installing ${pkg} into ${install_dir}"
    mkdir install_dir
    mv "${g_tmp_dir}/${pkg}"  "${install_dir}/"

    echo "Creating symlink ${nag_symlink} --> ${install_dir}/${nag_exe}"
    ln --symbolic "${install_dir}/${nag_exe}" "${nag_symlink}"
}

function install_verilator()
{
    echo "Installing verilator with apt-get"
    apt-get install verilator
}

function install_gnome_solarized()
{
    local old_cwd=$(pwd)

    local pkg='gnome-termianl-colors-solarized'
    local install_base_dir='/opt'
    local install_dir="${install_base_dir}/${pkg}"

    echo "Installing ${pkg} into ${install_dir}"
    cd "${install_base_dir}"
    git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git

    # Note: I could not find a way to create a new gnome-terminal profile from
    # the command line so make the user do it with the GUI
    echo -n "Create a gnome-terminal profile with the name "
    echo -n "'${g_profile_name}', switch to that profile in the current "
    read -p "terminal, then press the [Enter] key to continue..."

    echo "Setting profile ${g_profile_name} as default"
    gconftool-2 --set --type string /apps/gnome-terminal/global/default_profile "${g_profile_name}"

    cd "${install_dir}"
    echo "Running colorscheme install script"
    source install.sh

    cd "${old_cwd}"
}

function install_powerline_fonts()
{
    local old_cwd=$(pwd)

    local pkg='fonts'

    # Install the fonts
    cd "${g_dotvim_dir}/${pkg}"
    source install.sh

    # Use powerline fonts in terminal profile
    gconftool-2 --set "/apps/gnome-terminal/profiles/${g_profile_name}/use_system_font" --type=boolean false
    gconftool-2 --set "/apps/gnome-terminal/profiles/${g_profile_name}/font" --type string "Ubuntu Mono derivative Powerline 13"

    cd "${old_cwd}"
}


################################################################################
# Main program
################################################################################

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run with root permissions"
    exit 1
fi

echo "Making temp directory ${g_tmp_dir}"
mkdir "${g_tmp_dir}"

install_nagelfar
install_verilator
install_gnome_solarized
install_powerline_fonts

echo "Cleaning up ${g_tmp_dir}"

rm -rf "${g_tmp_dir}"
