#!/bin/bash
# https://docs.vagrantup.com/v2/provisioning/shell.html

#########
    #
    #  openVAS
    #
    #  shell script for provisioning of a debian 12 machine with openVAS.
    #
    #  @package     Debian-12-Trixie-CH
    #  @subpackage  openVAS
    #  @author      Christian Locher <locher@faithpro.ch>
    #  @copyright   2025 Faithful programming
    #  @license     http://www.gnu.org/licenses/gpl-3.0.en.html GNU/GPLv3
    #  @version     alpha - 2025-11-26
    #  @since       File available since release alpha
    #
    #########

function updateDebian {
    apt-get update
    apt-get full-upgrade -y
}

function setUpOpenVAS {
    # install dependency
    apt-get install -y libmagic-dev

    # install wget
    apt-get install -y wget

    # download openvas installation script
    wget https://raw.githubusercontent.com/Kastervo/OpenVAS-Installation/master/openvas_install.sh

    # uninstall wget
    apt-get purge -y wget

    # remove wget history
    rm .wget-hsts

    # prepare openvas installation script
    chmod +x openvas_install.sh

    # run openvas installation script
    ./openvas_install.sh

    # clean up
    apt-get purge -y libmagic-dev
    apt-get autoremove -y
    apt-get autoclean
}

echo "#################"
echo "# update debian #"
echo "#################"
updateDebian

echo "#################"
echo "# setup openvas #"
echo "#################"
setUpOpenVAS