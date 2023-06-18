#!/bin/bash
# update 2023.06.18

# --------------------------------------------------------
# Ubuntu 22.04にNVIDIA Container Toolkit (nvidia-docker)をインストール
# https://hirooka.pro/ubuntu-22-04-nvidia-container-toolkit-docker/
# --------------------------------------------------------
# 事前にnvidia-driverをインストールし、rebootする
# 
# apt-key proxy: --keyserver-option http-proxy=http://x:y@proxy:port
# https://qiita.com/nmatsui/items/816051fe6445db116e9a
#
# curl proxy: -x http://x:y@proxy:port
# https://qiita.com/tkj/items/c6dad4efc0dff4fecd93

# 確認(nvidia driver)
nvidia-smi

# 確認(nvidia cuda)
nvcc -V

echo "--------------------------------"
echo "docker install"
echo "--------------------------------"
sudo apt update
sudo apt install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg  
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
# Dockerコマンドをsudoなしで実行する方法
# URL:https://insilico-notebook.com/docker-run-without-sudo/
# URL:https://qiita.com/DQNEO/items/da5df074c48b012152ee
# dockerグループがなければ作る
sudo usermod -aG docker $USER
# 現行ユーザをdockerグループに所属させる
newgrp docker
# test
docker run hello-world

echo "--------------------------------"
echo "install NVIDIA Container Toolkit (nvidia-docker) " 
echo "--------------------------------"
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update
sudo apt install -y nvidia-docker2
sudo apt install -y nvidia-container-runtime
service docker restart

# docker: Error response from daemon: could not select device driver "" with capabilities: [[gpu]]. ERRO[0000] error waiting for container: context canceledを解決
# https://cocoinit23.com/docker-gpu-error-response-from-daemon-linux-runtime-spec-devices-could-not-select-device-driver-with-capabilities-gpu/
# https://qiita.com/murakamixi/items/5f6cf5c1ab6b4090f64a
# エラー時は以下のコマンドを実行
# sh nvidia-container-runtime-script.sh

# 確認(docker --gpus)
# sudo docker run --gpus all nvidia/cuda:11.0-base-ubuntu18.04 nvidia-smi
# sudo docker run --gpus all nvidia/cuda:11.7.0-base-ubuntu20.04 nvidia-smi
docker run --rm --gpus all nvidia/cuda:11.7.0-base-ubuntu22.04 nvidia-smi

# docker-composeの確認
#docker-compose -v
docker compose version
