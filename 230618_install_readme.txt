■Nvidia + Ubuntu 22.04 で画面が黄色いバグを直す
　参考: https://lookbackmargin.blog/2022/06/21/ubuntu-2204-nvidia-wayland/

言語選択画面で wayland を有効化
言語選択画面 > ターミナル起動(Ctrl + Alt + t) > wayland有効（geditでfalse > truneに編集)
$ sudo gedit /etc/gdm3/custom.conf
-----------------------------
[daemon]
# Uncomment the line below to force the login screen to use Xorg
WaylandEnable=true
-----------------------------


■インストール画面でウインドが欠けて設定できない場合
　参考：Ubuntu 20.04 LTS Desktopをインストールする
　　　https://redj.hatenablog.com/entry/2020/04/26/220635

・[ctrl] + [alt] + [t]で、ターミナルを起動
・以下を入力し、フォントサイズを変更
$ gsettings set org.gnome.desktop.interface text-scaling-factor 0.75

・他にも、Alt+F7でインストール画面のウィンドウを移動
　　↓
　Ubuntu18.04でも可能？

・他にも、Ubuntuをインストールする前に以下をインストールし、フォントサイズ変更
$ sudo apt install gnome-tweaks

■高速なネット環境で apt upgrade の更新数が多いと「jp.archive.ubuntu.com:http へ接続できません」のエラーが出る？
 参考: https://pcvogel.sarakura.net/2021/11/30/33554
------------------------------------------------------------------------------------------------------------
エラー:45 http://jp.archive.ubuntu.com/ubuntu focal-updates/main amd64 libsecret-1-0 amd64 0.20.4-0ubuntu1
  jp.archive.ubuntu.com:http へ接続できません: [IP: 160.26.2.187 80]
エラー:46 http://jp.archive.ubuntu.com/ubuntu focal-updates/main amd64 libatopology2 amd64 1.2.2-2.1ubuntu2.4
  jp.archive.ubuntu.com:http へ接続できません: [IP: 160.26.2.187 80]
エラー:47 http://jp.archive.ubuntu.com/ubuntu focal-updates/main amd64 libasound2 amd64 1.2.2-2.1ubuntu2.4
  jp.archive.ubuntu.com:http へ接続できません: [IP: 160.26.2.187 80]
------------------------------------------------------------------------------------------------------------

  対策: sudo apt updateの回数が多いため、一度実施したならコメントアウトする
　　　例: Ubuntu2004_install_public/install1/03_ubuntu20004_ros(noetic)_install.sh
         上記shを実行して、エラーが出た場合、sudo apt update && upgrade の行をコメントアウトし再度実行
