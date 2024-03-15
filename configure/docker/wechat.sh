## xhost +
## docker exec -it wechat bash
## su wechat
## WINEPREFIX=~/.deepinwine/Deepin-WeChat/ deepin-wine winecfg
### set to 200dpi
## docker restart wechat -t 0

mkdir -p ${HOME}/WeChat

docker run -d --name wechat \
    --restart always \
    --device /dev/snd \
    --ipc=host \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${HOME}/WeChatFiles:/WeChatFiles \
    -v ${HOME}/Downloads:/home/wechat/Downloads \
    -v ${HOME}/Documents:/home/wechat/Documents \
    -v ${HOME}/Pictures:/home/wechat/Pictures \
    -v ${HOME}/Templates:/home/wechat/Templates \
    -e WINEPREFIX=/home/wechat/.deepinwine/Deepin-WeChat \
    -e DISPLAY=unix$DISPLAY \
    -e XMODIFIERS=@im=fcitx \
    -e QT_IM_MODULE=fcitx \
    -e GTK_IM_MODULE=fcitx \
    -e AUDIO_GID=`getent group audio | cut -d: -f3`\
    -e GID=`id -g` \
    -e UID=`id -u` \
    bestwu/wechat
