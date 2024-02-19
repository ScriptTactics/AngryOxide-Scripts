# Angry-Oxide Raspbery Pi Configuration

You'll need the following:
- Raspberry Pi (3 or newer)
- Raspberry Pi OS
- Micro-SD or USB or SSD
- Angry-Oxide

## Raspberry Pi Setup

Follow the steps below to get your raspberry pi setup.

### Raspberry Pi Imager

Use the Raspberry Pi imager to flash the image onto either an Micro-SD card, USB flash drive, or SSD.

First select Choose Device, and select the Raspberry Pi you have.



Then choose your storage media, select next and flash!

Once it completes you can remove it from the computer.

**NOTE** If you're using a USB or SSD follow down to the next section [Addtional Configs (USB & SSD only)](#addtional-configs-usb--ssd-only), otherwise skip to [boot](#boot)

### Addtional Configs (USB & SSD only)

**THIS SECTION ONLY APPLIES TO THOSE USING A SSD OR USB FLASH DRIVE**

Edit the config.txt in the boot directory of your SSD or USB Flash drive


Replace the [pi4] section with the information below

```txt
[pi4]
max_framebuffers=2
dtoverlay=vc4-fkms-v3d
boot_delay
kernel=vmlinux
initramfs initrd.img followkernel
```

### Boot

Once you get the image flashed onto your Micro-SD card, SSD, or USB Flash Drive, connect it to your pi and boot up.

It may take a few seconds to a minute to boot up but once it's up and running you should be able to SSH into them.

To find the ip of the Pi you can check your router, run an nmap scan on your network, or connect your pi to a monitor and look at the console on boot.

To SSH run the following

```bash
ssh pi@<your-pis-ip>
```

ex: `ssh pi@192.168.1.1`

Default credentials:

```bash
username: pi
password: raspberry
```

After you've ssh'd into the Pi you should update and upgrade the system.

Run the following:

```bash
sudo apt update && sudo apt upgrade -y
```
Once that completes you're ready to get AngryOxide.

## Angry Oxide

Grab the latest Angry Oxide release from the GitHub [releases](https://github.com/Ragnt/AngryOxide/releases) page.

Or you can run one of the scripts in this repository.

`getAngryOxide.sh` will fetch the appropriate binary for your CPU archtitecture and install it on your path.

getAngryOxide.sh
```bash
#!/bin/bash
set -e


CPU_ARCHTIECTURE=$(lscpu | grep Architecture | awk {'print $2'})

wget https://github.com/Ragnt/AngryOxide/releases/download/v0.8.5/angryoxide-linux-${CPU_ARCHTIECTURE}-musl.tar.gz

tar -xvf angryoxide-linux-${CPU_ARCHTIECTURE}-musl.tar.gz

sudo mv angryoxide /usr/local/bin/

COMPETIONS=$(pkg-config --variable=completionsdir bash-completion)

sudo mv completions/agnryoxide $COMPETIONS

rm -rf angryoxide angryoxide-linux-${CPU_ARCHTIECTURE}-musl.tar.gz completions/
```

If you wish to build from source, `buildAngryOxide.sh` will do that for you.

buildAngryOxide.sh
```bash
#!/bin/bash

set -e

echo "Downloading rust...."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source $HOME/.cargo/env

echo "Cloning AngryOxide"

git clone https://github.com/Ragnt/AngryOxide.git
cd AngryOxide

echo "Building Project...."
make

echo "Installing AngryOxide"
sudo make install

echo "Installation complete"
```
You can run the script or follow the steps in the script

## Wardrive Mode

AngryOxide can be used for wardriving.


Using the scripts in this repository you can setup headless wardriving on Boot.

`setupWardrive.sh` will create a Systemd service to start on Boot that calls the `wardrive.sh` script. This will run AngryOxide when your machine first boots up and runs AngryOxide with the following flags:
- `--notransmit`
- `--headless`
- `--autexit`