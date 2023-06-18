#!/bin/bash
# update 2023.06.18

# --- Nvidia driver only ----------------------------
# Ubuntu 22.04にNVIDIA Driverをインストール
# https://hirooka.pro/nvidia-driver-ubuntu-22-04/

# echo "check driver "
#ubuntu-drivers devices

# echo "install nvidia driver"
#sudo ubuntu-drivers install

#echo "reboot"
#sudo reboot
# ----------------------------------------------------

# --- nvidia-driver, cuda ----------------------------
# NVIDIA GPU搭載PCにUbuntu 22.04LTSをインストールしてLinux機械学習環境を構築する（Tensorflow/PyTorch）
# https://take6shin-tech-diary.com/ubuntu2204_ml/
# check in URL > https://developer.nvidia.com/cuda-downloads 
# LINUX > x86_64 > Ubuntu > 22.04 > deb (network) 
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda

echo "after reboot"

echo "check nvidia-smi"
nvidia-smi

echo "chec nvcc"
nvcc --version

