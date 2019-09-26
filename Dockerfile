FROM ubuntu:16.04

# This Docker file builds a docker image for GPGPU-Sim, branch dev with ubuntu 16.04 and cuda 9.1
# It will download and install all the necessary packages including the cuda toolkit, so the overall image size will be around 4.4 GB

MAINTAINER zdchen <chenzd15thu@ucsb.edu>

############################
# Install the CUDA Toolkit #
############################

RUN apt-get update
RUN apt-get install -y wget
RUN wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
RUN dpkg -i cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install lightdm -y
RUN apt-get -y install cuda-9.1


############################
# Install Related Packages #
############################

# The requirement of packages can be found in https://github.com/gpgpu-sim/gpgpu-sim_distribution

RUN apt-get update
RUN apt-get -y install build-essential xutils-dev bison zlib1g-dev flex libglu1-mesa-dev
RUN apt-get -y install doxygen graphviz
RUN apt-get -y install python-pmw python-ply python-numpy libpng12-dev python-matplotlib
RUN apt-get -y install libxi-dev libxmu-dev
RUN apt-get -y install vim
RUN apt-get -y install git

# Setup the cuda toolkit environment
ENV CUDA_INSTALL_PATH=/usr/local/cuda
WORKDIR /home
RUN mkdir gpgpu_sim
WORKDIR /home/gpgpu_sim

# download the gpgpu-sim branch dev
RUN git clone https://github.com/gpgpu-sim/gpgpu-sim_distribution.git --branch dev
WORKDIR /home/gpgpu_sim/gpgpu-sim_distribution

RUN /bin/bash -c "source setup_environment"

# after entering the container, two further commands are required:
# source setup_environment
# make
