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
![imager](/pictures/imager.png)

First select Choose Device, and select the Raspberry Pi you have.
![Choose Device](/pictures/RPi%20Device.png)


Then select Raspberry Pi OS Lite (64-Bit)
![RPi OS](/pictures/Raspberry%20Pi%20OS%20Lite%20(64Bit).png)

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

[getAngryOxide.sh](/installations/getAngryOxide.sh) will fetch the appropriate binary for your CPU archtitecture and install it on your path.

If you wish to build from source, [buildAngryOxide.sh](/installations/buildAngryOxide.sh) will do that for you.

You can run the script or follow the steps in the script

## Wardrive Mode

AngryOxide can be used for wardriving.


Using the scripts in this repository you can setup headless wardriving on Boot.

[setupWardrive.sh](/wardrive/setupWardrive.sh) will create a Systemd service to start on Boot that calls the [wardrive.sh](/wardrive/wardrive.sh) script. This will run AngryOxide when your machine first boots up and runs AngryOxide with the following flags:
- `--notransmit`
- `--headless`
- `--autexit`