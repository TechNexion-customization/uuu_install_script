#!/usr/bin/env sh

DEFAULT_INSTALL_DIR='/usr/local/share/uuu'
DEFAULT_URL='ftp://ftp.technexion.net/development_resources/development_tools/installer/'
LATEST_FILE=$(curl -sl $DEFAULT_URL | grep imx-mfg-uuu | sort | tail -n1)
SYM_UUU='/usr/local/bin/uuu'

curl -JO "$DEFAULT_URL"/"$LATEST_FILE" && \
printf "Complete to download: %s \n" "$LATEST_FILE" || printf "Fails to download: %s !!!\n" "$LATEST_FILE"

if [ -d ${DEFAULT_INSTALL_DIR} ] ; then
    read -p "Remove existing uuu binary and directory? y/n : " yn
    case $yn in
    [Yy]* ) 
            sudo rm -r "$DEFAULT_INSTALL_DIR";
            which uuu || sudo rm "$(which uuu)"
            ;;
    [Nn]* ) exit;;
    * ) 
            echo "Please answer y or n."
            exit;;
    esac
fi

printf "Ask for create - %s \n" "$DEFAULT_INSTALL_DIR"
sudo mkdir -p "$DEFAULT_INSTALL_DIR"  && \
sudo unzip "$LATEST_FILE" -d "$DEFAULT_INSTALL_DIR"

ABS_FILE=$(readlink -f "$(find $DEFAULT_INSTALL_DIR -name "uuu" | grep linux64)")
printf "Create symlink /usr/local/bin/uuu to %s \n" "$ABS_FILE"
sudo ln -fs "$ABS_FILE" "$SYM_UUU"
sudo chmod a+x "$SYM_UUU"