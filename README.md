# uuu_install_script
Install i.mx uuu (mfgtool 3.0) in the host OS and simplify the usage of uuu for TechNexion i.mx product

# Steps
## Download and install `uuu` tool
    tn@ubuntu:~$ bash <(wget -qO- https://raw.githubusercontent.com/TechNexion-customization/uuu_install_script/master/uuu_install_script.sh)
    
## Flash image via `uuu_flash` command
    tn@ubuntu:~$ uuu_flash -b pico-imx8mm -i target_image

```
Usage: uuu_flash.sh
Optional parameters: [-b board_name] [-i target_image] [-l] [-h]"

  * This script is used to simplify the usage of uuu to flash target image
  *
  * [-b board_name]: specify the name of board/SOM, e.g., pico-imx6
  * [-i]: target image to be flashed
          (also accept image file compressed with .bz2 created by pbzip2)
  * [-l]: list all supported boards
  * [-h]: help
  * Usage: List and update supported boards status in existing uuu folder
  uuu_flash -l
  * Usage:
  uuu_flash -b platform -i target_image

  For example:
    $ uuu_flash -b pico-imx6 -i target_image
    $ uuu_flash -b pico-imx8mm -i target_image
```
