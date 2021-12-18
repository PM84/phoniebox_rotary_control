Date: 18.12.2021
Version: 1.3.6 - 20211218

# KY-040 Rotary Encoder Support for Phoniebox
This service will control the volume of a phoniebox by a KY-040 Rotary Encoder.

Codebase from: https://blog.ploetzli.ch/2018/ky-040-rotary-encoder-linux-raspberry-pi/
Adapted to Phoniebox Volume Control by Peter Mayer: https://github.com/PM84/phoniebox_helper.git

## Hardware
Tested with these rotary knobs KY-040 (affiliate Link): 
* <a href="https://amzn.to/33v1UTH" target="_blank">https://amzn.to/33v1UTH</a>
* <a href="https://amzn.to/32gduSc" target="_blank">https://amzn.to/32gduSc</a>

## Features:
Volume is adjusted when rotating by the step size entered in the Phoniebox UI.

Pressing the knob mutes the audio.
Pressing the knob again sets the volume to the boot volume (cf. Phoniebox UI)

## One Line Installer
The installation is pretty easy with the one line installer. 
![One Line Installer](https://raw.githubusercontent.com/splitti/phoniebox_rotary_control/main/media/prc_install.gif)

You just need the GPIO's of the rotary encoder pins CLK, DT and SW.

Here is the installer:
> cd; rm prc_installer.sh; wget https://raw.githubusercontent.com/splitti/phoniebox_rotary_control/master/scripts/install/prc_installer.sh; chmod +x prc_installer.sh; ./prc_installer.sh

## Support
You can use the discord-channel for support: <a href="https://discord.gg/pNNHUaCSAD" target="_blank">https://discord.gg/pNNHUaCSAD</a>

## Spend me a coffee
<a href="http://paypal.me/splittscheid" target="_blank">paypal.me</a>


## Changelog
- 18.12.2021 v1.3.6
  - adding submodule
  - changing some variables
  - optimizing speed issues
- 18.12.2021 v1.2.8
  - Bug fixing
  - Add uninstall
  - Add configuration in installer
  - Add editing config.txt
- 17.12.2021 v1.1.0
  - New rotary control
  - Bug fixing
- 16.12.2021 v.1.0.1
  - Added Installer
  - Bug fixing