#!/usr/bin/env bash
#
# Script to install the required packages and do the required setup for my Vim
# environment to work properly.
# Target environment is Ubuntu 14.04 LTS

set -e
#set -x  # Uncomment for debug output

################################################################################
# Globals
################################################################################

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in
g_dotvim_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

g_tmp_dir='/tmp/vim_env_install_work'
g_nagelfar_release='123'
g_profile_name='test-vim-solarized'
g_profile_x=''

################################################################################
# Functions
################################################################################

function get_profile_name()
{
   # TODO get list of profiles from gconftool-2, parse the list, and match the
   # each 'ProfileX' to the visible-name, then set g_profile_x to that
   # 'ProfileX' string
   echo "TODO" 
}

function install_nagelfar()
{
    local old_cwd=$(pwd)

    local pkg="nagelfar${g_nagelfar_release}"
    local install_dir='/opt'
    local nag_exe='nagelfar.tcl'
    local nag_exe_path="${install_dir}/${pkg}/${nag_exe}"
    local nag_symlink="/usr/local/bin/${nag_exe}"

    cd "${g_tmp_dir}"
    
    echo "Downloading ${pkg}"
    wget "https://sourceforge.net/projects/nagelfar/files/Rel_${g_nagelfar_release}/${pkg}.tar.gz"

    echo "Unpacking ${pkg}"
    tar -zxvf "${pkg}.tar.gz"

    echo "Installing ${pkg} into ${install_dir}"
    mkdir -p "${install_dir}"
    echo "Need permission to move ${pkg} to ${install_dir}"
    sudo mv "${pkg}" "${install_dir}"

    echo "Need permission to create symlink ${nag_symlink} -> ${nag_exe_path}"
    sudo ln --symbolic "${nag_exe_path}" "${nag_symlink}"

    cd "${old_cwd}"
}

function install_verilator()
{
    echo "Need permission to install verilator with apt-get"
    sudo apt-get install -y verilator
}

function install_gnome_solarized()
{
    local old_cwd=$(pwd)

    local gnometerm_pkg='gnome-terminal-colors-solarized'
    local dircolors_pkg='dircolors-solarized'
    local solarized_dir='.solarized'
    local install_dir="${HOME}/${solarized_dir}"

    echo "Need permission to install dconf-cli with apt-get"
    sudo apt-get install -y dconf-cli

    echo "Installing Solarized color scheme for terminal"
    mkdir "${install_dir}"
    cd "${install_dir}"

    echo "Downloading ${gnometerm_pkg}"
    git clone https://github.com/Anthony25/${gnometerm_pkg}.git

    # Note: I could not find a way to create a new gnome-terminal profile from
    # the command line so make the user do it with the GUI
    echo "Create a gnome-terminal profile with the name '${g_profile_name}'."
    echo "You may want to set '${g_profile_name}' as the default profile."
    read -p "When finished, press the [Enter] key to continue..."
    echo "Switch to the profile '${g_profile_name}' in this terminal."
    read -p "When finished, press the [Enter] key to continue..."

    #get_profile_name TODO

    cd "${install_dir}/${gnometerm_pkg}"
    echo "Installing ${gnometerm_pkg}"
    #./install.sh --scheme=dark_alternative --profile="${g_profile_x}" #FIXME need to use ProfileX not name I gave it...
    ./install.sh


    cd "${install_dir}"
    echo "Downloading ${dircolors_pkg}"
    git clone https://github.com/seebi/${dircolors_pkg}.git

    cd "${install_dir}/${dircolors_pkg}"
    echo "Installing ${dircolors_pkg}"
    ln --symbolic "${install_dir}/${dircolors_pkg}/dircolors.256dark" "${HOME}/.dir_colors"
    echo "Adding dircolors configuration to bashrc"
    echo '' >> "${HOME}/.bashrc"
    echo '# Use solarized color scheme for ls output' >> "${HOME}/.bashrc"
    echo 'eval `dircolors ~/.dir_colors`' >> "${HOME}/.bashrc"

    cd "${old_cwd}"
}

function install_powerline_fonts()
{
    local old_cwd=$(pwd)

    local pkg='fonts'

    # Install the fonts
    cd "${g_dotvim_dir}/bundle/${pkg}"
    ./install.sh

    # Use powerline fonts in terminal profile FIXME nneed to use ProfileX not name I gave it...
    #gconftool-2 --set "/apps/gnome-terminal/profiles/${g_profile_x}/use_system_font" --type=boolean false
    #gconftool-2 --set "/apps/gnome-terminal/profiles/${g_profile_x}/font" --type string "Ubuntu Mono derivative Powerline 13"
    echo "Go to profile preferences for '${g_profile_name}' and do the following:"
    echo "1) uncheck 'Use the system fixed width font' box"
    echo "2) set 'Font:' to Ubuntu mono derivative Powerline 13"
    read -p "When finished, press the [Enter] key to continue..."

    cd "${old_cwd}"
}


################################################################################
# Main program
################################################################################

# Cache user credentials so all other sudos will work without password, IF the
# sudo timeout is set to a reasonable time
echo "Please enter your password for sudo"
sudo -v

echo "Making temp directory ${g_tmp_dir}"
mkdir -p "${g_tmp_dir}"

install_nagelfar
install_verilator
install_gnome_solarized
install_powerline_fonts

echo "Creating links for .vimrc and .ycm_extra_conf.py in ${HOME}"
ln --symbolic "${g_dotvim_dir}/.vimrc" "${HOME}/.virmc"
ln --symbolic "${g_dotvim_dir}/.ycm_extra_conf.py" "${HOME}/.ycm_extra_conf.py"

echo "Cleaning up ${g_tmp_dir}"
rm -rf "${g_tmp_dir}"

echo -n "YOU WILL NEED TO CLOSE AND RE-LAUNCH THE TERMINAL FOR DIRCOLORS "
echo "TO TAKE EFFECT"
