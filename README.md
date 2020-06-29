# uuu_install_script
Install i.mx uuu (mfgtool 3.0) in the host OS and simplify the usage of uuu for TechNexion i.mx product

# Steps
## Download and install `uuu` tool
    tn@ubuntu:~$ bash <(wget -qO- https://raw.githubusercontent.com/TechNexion-customization/uuu_install_script/master/uuu_install_script.sh)
    
## Flash image via `uuu_tn` command
    tn@ubuntu:~$ uuu_tn -b pico-imx8mm -i target_image

```
Usage: uuu_tn.sh
    Optional parameters: [-b board_name] [-i target_image] [-l] [-h]
    * [-b board_name]: specify the name of board/SOM, e.g., pico-imx6
    * [-i]: target image to be flashed
            (also accept image file compressed with .bz2 created by pbzip2)
    * [-l]: list all supported boards
    * [-h]: help
```
