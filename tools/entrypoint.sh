#!/bin/sh

Xvfb $DISPLAY -pixdepths 32 -screen 0 800x600x24 >/dev/null 2>&1 & XPID=$!;
 
xfreerdp /f \
         /cert-ignore \
         /rdp2tcp:/opt/rdp2tcp/client \
         /drive:shared,/opt/rdp2tcp \
         /v:"$HOST" \
         /u:"$USERNAME" \
         /p:"$PASSWORD" \
         /bpp:8 \
         /network:modem \
         /compression -themes -wallpaper \
         /auto-reconnect \
         /audio-mode:1 \
         +fonts \
         +glyph-cache | tee &

while [ -z "$freerdp_window" ];do
    sleep .5
    freerdp_window=$(xdotool search --class FreeRDP | head -n 1);
done

xdotool key --window $freerdp_window Return # Send enter to skip any login warning


if [ ! -z "$PORTS" ];then
    echo $PORTS | tr ";" "\n" | while read line; do
        if [ ! -z "$line" ];then

            PORT=$(echo $line | tr ":" " ")
            PORT_BIND_PORT=$(echo $PORT | awk '{print $1}' | head -n 1)
            PORT_BIND_TO_PORT=$(echo $PORT | awk '{print $2}' | head -n 1)

            /opt/rdp2tcp/rdp2tcp.py add forward $(hostname -i) $PORT_BIND_PORT 127.0.0.1 $PORT_BIND_TO_PORT > /dev/null

            echo "Port forward: $(hostname -i):$PORT_BIND_PORT -> $HOST:$PORT_BIND_TO_PORT "

        fi
    done
fi

sleep 2;

# Opening server.exe on remote host 
xdotool key --window $freerdp_window Super+r
echo 'cmd /c //tsclient//shared//server.exe' | xclip -selection c # Using xclip because xdotool type has a problem with unicode
xdotool key --window $freerdp_window Ctrl+v
xdotool key --window $freerdp_window Return
sleep 5;
xdotool key --window $freerdp_window Super+Down



if [ ! -z "$@" ];then
    exec $@
    exit
fi

while true;do      
    sleep .5
done

