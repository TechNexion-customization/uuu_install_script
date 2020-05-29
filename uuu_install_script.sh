#!/usr/bin/env sh

#################################################################################
# Copyright 2019 Technexion Ltd.
#
# Author: Richard Hu <richard.hu@technexion.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#################################################################################

DEFAULT_INSTALL_DIR='/usr/local/share/uuu'
UUU_ZIP_URL='ftp://ftp.technexion.net/development_resources/development_tools/installer/'
UUU_FLASH_SCRIPT='https://raw.githubusercontent.com/richard-hu/uuu_install_script/master/uuu_flash'
UUU_FLASH_EXE='uuu_flash'
#LATEST_FILE=$(curl -sl $UUU_ZIP_URL | grep imx-mfg-uuu | sort | tail -n1)

echo "Connecting to TechNexion FTP..."
FTP_FILE_LIST=$(curl -sl $UUU_ZIP_URL | grep imx-mfg-uuu | sort -r)
BIN_PATH='/usr/local/bin'
FTP_FILE_LIST_ARR=($FTP_FILE_LIST)

PS3="Please select uuu package: "
select OPTION in "${FTP_FILE_LIST_ARR[@]}"
do
    case  $OPTION  in
        "") echo Please select option between 1 to ${#FTP_FILE_LIST_ARR[@]}
        ;;
        *) curl -sJO "$UUU_ZIP_URL"/"$OPTION" && \
            if [ "$?" = "0" ]; then
                printf "Complete to download: %s \n" "$OPTION"
                break
            else
                printf "Fails to download: %s !!!\n" "$OPTION"
                exit 1
            fi
        ;;
        esac
done

if [ -d ${DEFAULT_INSTALL_DIR} ] ; then
    read -p "Remove existing uuu binary and directory? y/n : " yn
    case $yn in
    [Yy]* )
            EXEC_UUU=$(command -v uuu)
            if [ ! -z "$EXEC_UUU" ] ; then
                printf "Removing %s ... \n" "$EXEC_UUU"
                sudo rm "$EXEC_UUU"
            fi
            sudo rm -r "$DEFAULT_INSTALL_DIR"
            ;;
    [Nn]* ) exit;;
    * ) 
            echo "Please answer y or n."
            exit;;
    esac
fi

printf "Ask for create - %s \n" "$DEFAULT_INSTALL_DIR"
sudo mkdir -p "$DEFAULT_INSTALL_DIR"  && \
sudo unzip "$OPTION" -d "$DEFAULT_INSTALL_DIR"
rm "$OPTION"

ABS_FILE=$(readlink -f "$(find $DEFAULT_INSTALL_DIR -name "uuu" | grep linux64)")
printf "Create symlink $BIN_PATH/uuu to %s \n" "$ABS_FILE"
sudo ln -fs "$ABS_FILE" "$BIN_PATH"/uuu
sudo chmod a+x "$BIN_PATH"/uuu

echo 'Fetching uuu_flash...'
curl -sO "$UUU_FLASH_SCRIPT"
if [ "$?" = "0" ]; then
    printf "Complete to fetch: %s \n" "$UUU_FLASH_EXE"
    printf "Install %s to %s \n" "$UUU_FLASH_EXE" "$BIN_PATH"
    sudo chmod a+x "$UUU_FLASH_EXE"
    sudo mv "$UUU_FLASH_EXE" "$BIN_PATH"
else
    printf "Fails to fetch: %s !!!\n" "$UUU_FLASH_EXE"
    exit 1
fi
