xauth
XSOCK=/tmp/.X11-unix\
XAUTH=/tmp/.docker.xauth
XFILE=/run/user/1000

TK_DATAPATH=./
TK_XAUTH=$XAUTHORITY
TK_DOWNLOAD=/home/$USER/Downloads
DOCKER_HOME=/root/

USER=tk1star2

echo "TK XAUTH is " $TK_XAUTH

nvidia-docker run -d \
	-p 6006:6006 \
	-p 8888:8888\
	-e DISPLAY=$DISPLAY \
	-e XAUTHORITY=$TK_AUTH \
	-e XDG_RUNTIME_DIR=$XFILE \
	--env="QT_X11_NO_MITSHM=1"\
	--net=host \
	--workdir="/root" \
	--ipc=host \
	--shm-size=16g \
	-v $XSOCK:$XSOCK:rw \
	-v $TK_XAUTH:$XAUTH:rw \
	-v $TK_DATAPATH/dataset:$DOCKER_HOME/dataset:rw \
	-v $TK_DOWNLOAD:/Downloads \
	--name ubuntu18.04-cuda9.0-cudnn7 \
	-it tk1star2/tensorflow:tf1.14-trt6.0.1 bash

docker cp ./X11 pyTorch:/root/
sudo xhost +local:root

#sudo cp /home/tk1star2/.Xauthority /root/
#sudo xhost +local:root

#nvidia-docker run -d -p 6006:6006 -e DISPLAY=$DISPLAY \
#        --env="QT_X11_NO_MITSHM=1"\
#        --net=host \
#        --workdir="/root" \
#        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
#        -v /root/.Xauthority:/root/.Xauthority:rw \
#        -v /home/tk1star2/Desktop/tk/tk_framework/tensorflow2/Desktop:/root/dataset:rw \
#        --name tsflow2 -it nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04 bash
#docker cp ./X11 tsflow:/root/

