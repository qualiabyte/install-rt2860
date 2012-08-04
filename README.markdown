# Install-RT2860

Install the RT2860 driver from source. For Asus EEE + Ubuntu.

## Background

The ASUS EEE 1000h netbook (and similar hardware) ships with a wireless card not completely supported by Ubuntu 10.04 (and later). The Ralink driver is open source, and can be used with slight modification.

This script automates driver download, patch, and installation - including the compilation step, which must be run with each kernel upgrade.

See also:

+ [Chris Barker's original solution][CTBarker]
+ [Ubuntu: [SOLVED] Ubuntu 10.04 using the Ralink RT2860 WiFi chipset (e.g. EeeBox B202)][Ubuntu]
+ [Gentoo Wiki: RT2860][Gentoo]
+ [Ralink RT2860 Linux Driver Download][Ralink]

[CTBarker]: http://www.ctbarker.info/2010/05/ubuntu-1004-wireless-chipsets-and-wpa.html
[Ubuntu]: http://ubuntuforums.org/showthread.php?t=1476007
[Gentoo]: http://en.gentoo-wiki.com/wiki/Ralink_RT2860
[Ralink]: http://www.ralinktech.com/en/04_support/support.php?sn=501

## Compatibility

Written and tested on the ASUS EEE 1000h netbook + Ubuntu 10.04.

If you experience success (or problems), add your system info to the wiki's [compatibility page][Compatibility].

[Compatibility]: https://github.com/qualiabyte/install-rt2860/wiki/Compatibility

## Install

The driver can be installed with the following command:

    $ git clone https://github.com/qualiabyte/install-rt2860 \
        && cd install-rt2860 \
        && sudo ./install-rt2860.sh

That's it! The driver should now be installed.

## Further Usage

The install script has a few options:

    $ ./install-rt2860.sh --help

        install-rt2860.sh

        Usage:
            sudo install-rt2860.sh

        Options:
            -d, --debug     Show debug info.
            -h, --help      Show this usage info.
            -q, --quick     Quick mode; don't rebuild sources.

Note that the script should be run with sudo: `sudo ./install.sh`.

The `--debug` option prints each executed shell command, helpful to spot if anything goes wrong.

The `--quick` option skips the compilation step, helpful if the sources are already compiled.

## Patches Welcome

If you've spotted a bug or found a way to support more use cases (i.e., hardware or distro releases), feel free to open an issue or pull request.
