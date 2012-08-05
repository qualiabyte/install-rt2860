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

### Default Install (No network access)

These instructions are intended to help you install the RT2860 driver on a system without reliable network access:

1. Download the [latest release][LatestRelease] archive from a computer with network access.
2. Copy the archive `install-rt2860-latest.tar.gz` to a USB drive (or other media).
3. Transfer the archive from USB to the system with the RT2860 hardware.
4. Extract the archive. In the terminal:

        $ tar xvzf install-rt2860-latest.tar.gz

5. Change into the new directory. For version 0.0.1:

        $ cd install-rt2860-0.0.1

6. Run the install script with sudo. It may take a few minutes to compile:

        $ sudo ./install-rt2860.sh

That's it! The driver should now be installed.

[LatestRelease]: https://github.com/downloads/qualiabyte/install-rt2860/install-rt2860-latest.tar.gz

### Alternative Install (With network access)

The driver can also be installed with the following command:

    $ git clone https://github.com/qualiabyte/install-rt2860 \
        && cd install-rt2860 \
        && sudo ./install-rt2860.sh

This will clone the latest version of this repo and run the install script.

The install script will fetch the Ralink sources (if not present), and then patch, compile, and install the driver.

## Further Usage

The install script has a few options:

    $ ./install-rt2860.sh --help

        install-rt2860.sh

        Usage:
            sudo install-rt2860.sh

        Options:
            -d, --debug      Show debug info.
            -f, --fetch-only Just fetch archive; don't build or install.
            -h, --help       Show this usage info.
            -q, --quick      Quick mode; don't rebuild sources.

Note that the script should be run with sudo: `sudo ./install.sh`.

The `--debug` option prints each executed shell command, helpful to spot if anything goes wrong.

The `--quick` option skips the compilation step, helpful if the sources are already compiled.

## Patches Welcome

If you've spotted a bug or found a way to support more use cases (i.e., hardware or distro releases), feel free to open an issue or pull request.
