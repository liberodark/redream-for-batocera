#!/bin/bash
#
# About: Install Redream automatically
# Author: liberodark
# Thanks : 
# License: GNU GPLv3

version="0.0.1"

echo "Welcome on Redream Install Script $version"

download_redream(){
   echo "Download Redream"
   wget https://github.com/liberodark/redream-for-batocera/releases/download/1.5.0/redream.zip > /dev/null 2>&1
   unzip -Do redream.zip
   rm -f redream.zip
}

download_es_systems(){
   echo "Download es_systems"
   wget https://raw.githubusercontent.com/liberodark/redream-for-batocera/master/es_systems.cfg > /dev/null 2>&1
   if [ -e "/userdata/system/configs/emulationstation/es_systems.cfg" ]; then
   mv /userdata/system/configs/emulationstation/es_systems.cfg /userdata/system/configs/emulationstation/es_systems.cfg.bak
   fi
   mv es_systems.cfg /userdata/system/configs/emulationstation/es_systems.cfg
   rm -f es_systems.cfg
}

install() {
    echo "Install Redream"
    cd /userdata/ || exit
    download_redream
    mkdir -p "/userdata/roms/dreamcast"
    download_es_systems
    batocera-save-overlay
    /etc/init.d/S31emulationstation restart > /dev/null 2>&1
    echo "Done."
}

install
