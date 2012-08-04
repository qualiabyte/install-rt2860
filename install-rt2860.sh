#!/bin/bash

# install-rt2860.sh
# Installs the rt2860 driver from source.

# Debug off by default.
DEBUG=

# Quick off by default.
QUICK=

# Ralink driver source dir.
RALINK_SRC='2010_07_16_RT2860_Linux_STA_v2.4.0.0'

# Ralink driver archive.
RALINK_TGZ="${RALINK_SRC}.tar.gz"

# Ralink driver archive url.
RALINK_URL="https://github.com/downloads/qualiabyte/install-rt2860/${RALINK_TGZ}"

#
# Print usage information.
#
usage() {
    cat <<-Usage

    install-rt2860.sh

    Usage:
        sudo install-rt2860.sh

    Options:
        -d, --debug     Show debug info.
        -h, --help      Show this usage info.
        -q, --quick     Quick mode; don't rebuild sources.

Usage
}

#
# Run commands without elevated permissions.
#
nosudo() {
    sudo -u "$SUDO_USER" "$@"
}

#
# Parse commandline options.
#
getOpts() {
    while [[ "$1" == -* ]]; do
        case "$1" in
            -d | --debug    ) DEBUG=1; set -x; shift ;;
            -q | --quick    ) QUICK=1; shift ;;
            -h | --help     ) usage; exit 0 ;;
            *               ) shift ;;
        esac 
    done
}

#
# Main entry point.
#
main() {
    getOpts "$@"

    # Check user
    if test "$USERNAME" != 'root'; then
        echo "Please run this script with sudo: "
        usage; exit 1
    fi

    # Get sources
    test -f $RALINK_TGZ || \
        nosudo wget $RALINK_URL

    # Unzip
    test -d $RALINK_SRC || \
        nosudo tar xzf $RALINK_TGZ

    # Change to source dir
    cd $RALINK_SRC

    # Apply patches
    nosudo patch --forward -p1 < ../ralink-rt2860.patch

    # Rebuild
    if test ! $QUICK; then
        nosudo make clean
        nosudo make
    fi

    # Install
    sudo make install

    # Unload old driver
    sudo ifconfig ra0 down
    sudo rmmod rt2860sta

    # Backup old driver
    local date=$( date +%Y.%m.%d )
    local release=$( uname -r )
    local stagingDir="/lib/modules/${release}/kernel/drivers/staging/rt2860"
    local src="${stagingDir}/rt2860sta.ko"
    local dst="${src}-${date}"
    test -e $src -a ! -e $dst && \
        sudo cp $src $dst

    # Load new driver
    sudo depmod -a
    sudo modprobe rt2860sta
    sudo ifconfig ra0 up

    # Install driver in staging dir
    sudo cp 'os/linux/rt2860sta.ko' "${stagingDir}/"

    # Ensure driver loads at boot
    grep 'rt2860sta' /etc/modules || \
        sudo echo 'rt2860sta' >> /etc/modules
}

# Let's do this!
main "$@"
