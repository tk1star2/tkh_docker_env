#filename : run.sh
#!/bin/sh

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
USER=kimsDocker
nvidia-docker run \
	-it --rm \
	-p 8888:8888 -p 6006:6006 \
	-v /run/user/1000:/run/user/1000 \
	-v /dev/snd:/dev/snd \
	-v $XSOCK:$XSOCK:rw \
	-v $XAUTH:$XAUTH:rw \
	-e XAUTHORITY=${XAUTH} \
	-e DISPLAY=${DISPLAY} \
	--shm-size=16g \
	--ipc=host \
	--net=host \
	-e XDG_RUNTIME_DIR=/run/user/1000 \
	-v /data/:/data/ \
	-v /home/thfm/Downloads/pycharm-2019.2.3/:/pycharm/ \
	-v /home/thfm/.PycharmCE2019.2/:/.PycharmCE2019.2/ \
	-v /home/thfm/Downloads/:/Downloads/ \
	adg-yskim/tensorflow:tf1.14-trt6.0.1 /bin/bash