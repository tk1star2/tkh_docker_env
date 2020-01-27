#File name must be : Dockerfile
#This is for making docker image

FROM nvcr.io/nvidia/tensorflow:19.10-py3
MAINTAINER TAEKOAN Yoo <tk1star2@nate.com>

RUN apt-get update && apt-get install -y \
	software-properties-common \
	wget curl git cmake cmake-curses-gui

RUN apt-get update && apt-get install -y \
	libnlopt-dev freeglut3-dev qtbase5-dev \
	libqt5opengl5-dev libssh2-1-dev libarmadillo-dev libpcap-dev \
	libglew-dev

# Develop
RUN apt-get install -y \
	libboost-all-dev \
	libflann-dev \
	libgsl0-dev \
	libgoogle-perftools-dev \
	libeigen3-dev

RUN apt-get install -y \
	xz-utils file locales dbus-x11 pulseaudio dmz-cursor-theme \
	fonts-dejavu fonts-liberation hicolor-icon-theme \
	libcanberra-gtk3-0 libcanberra-gtk-module libcanberra-gtk3-module \
	libasound2 libgtk2.0-0 libdbus-glib-1-2 libxt6 libexif12 \
	libgl1-mesa-glx libgl1-mesa-dri \
	&& update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX

# Install some basic GUI tools
RUN apt-get install -y \
	cmake-qt-gui \
	gnome-terminal \
	nautilus \
	gedit

ENV DEBIAN_FRONTEND=noninteractive

# Additional PKG
RUN apt-get install -y \
	python3-tk \
	tk-dev

RUN apt-get install -y \
	sudo

# Python Packages
# COPY requirements.txt /tmp/
# RUN pip install -r /tmp/requirements.txt

ENV PKG_CONFIG_PATH $PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

# Add basic user
ENV USERNAME tk1star2
ENV PULSE_SERVER /run/pulse/native
RUN useradd -m $USERNAME && \
	echo "$USERNAME:$USERNAME" | chpasswd && \
	usermod --shell /bin/bash $USERNAME && \
	usermod -aG sudo $USERNAME && \
	echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
	chmod 0440 /etc/sudoers.d/$USERNAME && \
	# Replace 1000 with your user/group id
	usermod --uid 1000 $USERNAME && \
	groupmod --gid 1000 $USERNAME

# Setup .bashrc
RUN \
	# Fix for qt and X server errors
	echo "export QT_X11_NO_MITSHM=1" >> /home/$USERNAME/.bashrc && \
	# cd to home on login
	echo "cd" >> /home/$USERNAME/.bashrc
# Change user
# USER kimsDocker
