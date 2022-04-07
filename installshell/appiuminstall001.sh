#!/bin/bash

echo "-----------------------------------------------------"
echo "--------------开始创建appium环境---------------------"
echo "-----------------------------------------------------"
sudo -S date
echo "--------------步骤1：配置ROOT密码---------------------"
sudo passwd root


echo "--------------步骤2：升级Ubuntu-----------------------"
# 升级ubuntu
sudo apt update -y 
sudo apt upgrade -y
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "升级ubuntu完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]升级ubuntu失败，请手动输入升级命令查看"
echo "-----------------------------------------------------"
exit 0
fi
echo "--------------步骤3：安装gcc make cmake---------------"
# 安装gcc、make、cmake
sudo apt install gcc -y
sudo apt install make -y
sudo apt install cmake -y
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "安装gcc、make、cmake完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]安装gcc、make、cmake失败，请手动输入升级命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

echo "--------------步骤4：安装openssh vim zip git----------"
# 安装openssh vim 
sudo apt install openssh-server -y
sudo apt install vim -y
sudo apt install zip -y
sudo apt install git -y

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

sudo tee -a /etc/ssh/sshd_config <<EOF
PermitRootLogin yes
EOF

if test $? = 0 
then
echo "-----------------------------------------------------"
echo "修改openssh配置成功"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]修改openssh配置失败"
echo "-----------------------------------------------------"
exit 0
fi

echo "--------------步骤5：创建appium管理员-----------------"
cd /home
echo "当前目录："
pwd
#创建appium管理员
if test -d appium
then
echo "-----------------------------------------------------"
echo "appium管理员用户已经存在，开始下一步，检查当前用户"
echo "-----------------------------------------------------"
else
echo "------------------------------------------------"
echo "appium管理员用户不存在，开始创建appium管理员用户"
echo "------------------------------------------------"
sudo adduser appium<<EOF
appiumadmin123
appiumadmin123
EOF
sudo usermod -aG 4,24,27,30,46,120,132,133 appium
id appium
echo "-----------------------------------------------------"
echo "appium管理员创建成功，请切换appium管理员用户执行本脚本！"
echo "user:appium ------------------------"
echo "passwd:appiumadmin123 --------------"
echo "-----------------------------------------------------"
exit 0
fi

presentuser=$(whoami)
echo "当前用户是：$presentuser"

appiumuser="appium"
if test $presentuser = $appiumuser
then
echo "-----------------------------------------------------"
echo "当前用户是appium管理员，开始进行下一步"
echo "-----------------------------------------------------"
else
echo "-----------------------------------------------------"
echo "当前用户不是appium管理员，请切换用户执行本脚本！"
echo "user:appium ------------------------"
echo "passwd:appiumadmin123 --------------"
echo "-----------------------------------------------------"
exit 0
fi


echo "--------------步骤6：安装nodejs npm-------------------"
cd /home/appium
echo "当前目录："
pwd

#安装nodejs
if test -d nodejs
then
echo "-----------------------------------------------------"
echo "nodejs文件夹已存在"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "nodejs文件夹不存在，创建nodejs文件夹"
echo "-----------------------------------------------------"
mkdir nodejs
fi
cd nodejs
echo "当前目录："
pwd

wget https://nodejs.org/dist/v17.8.0/node-v17.8.0-linux-x64.tar.xz
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "wget-node-v17.8.0-linux-x64.tar.xz成功"
echo "-----------------------------------------------------"
else
echo "-----------------------------------------------------"
echo "wget-node-v17.8.0-linux-x64.tar.xz失败"
echo "-----------------------------------------------------"
exit 0
fi

tar -xvf node-v17.8.0-linux-x64.tar.xz
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "node-v17.8.0-linux-x64.tar.xz解压成功"
echo "-----------------------------------------------------"
else
echo "-----------------------------------------------------"
echo "node-v17.8.0-linux-x64.tar.xz解压失败"
echo "-----------------------------------------------------"
exit 0
fi

cd /opt
echo "当前目录："
pwd
if test -d node-v17.8.0-linux-x64
then
echo "-----------------------------------------------------"
echo "node-v17.8.0-linux-x64文件夹已存在"
echo "-----------------------------------------------------"
sudo rm -rf node-v17.8.0-linux-x64
echo "当前目录："
pwd
else 
echo "-----------------------------------------------------"
echo "node-v17.8.0-linux-x64文件夹不存在，进行下一步！"
echo "-----------------------------------------------------"
fi
cd /home/appium/nodejs
echo "当前目录："
pwd

sudo mv node-v17.8.0-linux-x64 /opt

sudo ln -s /opt/node-v17.8.0-linux-x64 /usr/local/bin/node-v17.8.0
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "node-v17.8.0-linux-x64软连接成功"
echo "-----------------------------------------------------"
else
echo "-----------------------------------------------------"
echo "node-v17.8.0-linux-x64软连接失败"
echo "-----------------------------------------------------"
exit 0
fi

sudo cp /etc/profile /etc/profile.nodejsbackup
sudo tee -a /etc/profile << "EOF"
export NODE_HOME=/usr/local/bin/node-v17.8.0
export PATH=$NODE_HOME/bin:$PATH
export NODE_PATH=$NODE_HOME/lib/node_modules
EOF
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "node-v17.8.0-linux-x64环境变量添加成功"
echo "-----------------------------------------------------"
else
echo "-----------------------------------------------------"
echo "node-v17.8.0-linux-x64环境变量添加失败"
echo "-----------------------------------------------------"
exit 0
fi
source /etc/profile

node -v
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "node安装成功"
echo "-----------------------------------------------------"
else
echo "-----------------------------------------------------"
echo "node安装失败"
echo "-----------------------------------------------------"
exit 0
fi

npm -v
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "npm安装成功"
echo "-----------------------------------------------------"
else
echo "-----------------------------------------------------"
echo "npm安装失败"
echo "-----------------------------------------------------"
exit 0
fi

echo "--------------步骤7：安装ffmpge----------------------"
# 安装ffmpge
cd /home/appium
echo "当前目录："
pwd
if test -d ffmpeg
then
echo "-----------------------------------------------------"
echo "ffmpeg文件夹已存在"
echo "-----------------------------------------------------"
rm -rf ffmpeg/
mkdir ffmpeg
else 
echo "-----------------------------------------------------"
echo "ffmpeg文件夹不存在，创建nodejs文件夹"
echo "-----------------------------------------------------"
mkdir ffmpeg
fi

cd ffmpeg
echo "当前目录："
pwd

wget https://www.ffmpeg.org/releases/ffmpeg-5.0.1.tar.xz
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "wget-ffmpge完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]wget-ffmpge失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi
tar -xvf ffmpeg-5.0.1.tar.xz
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "tar-ffmpge完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]tar-ffmpge失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

cd ffmpeg-5.0.1
echo "当前目录："
pwd

wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "wget-fyasm-1.3.0完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]wget-yasm-1.3.0失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

tar -xvf yasm-1.3.0.tar.gz
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "tar-fyasm-1.3.0完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]tar-yasm-1.3.0失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

cd yasm-1.3.0/
echo "当前目录："
pwd

./configure
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "./configuret-yasm完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]./configure-yasm失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

make
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "make-yasm完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]make-yasm失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

sudo make install
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "install-yasm完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]install-yasm失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

cd /home/appium/ffmpeg/ffmpeg-5.0.1
echo "当前目录："
pwd

./configure --enable-shared --prefix=/monchickey/ffmpeg
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "./configuret-ffmpge完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]./configure-ffmpge失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

make
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "make-ffmpge完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]make-ffmpge失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

sudo make install
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "install-ffmpge完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]install-ffmpge失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

cd /home/appium
echo "当前目录："
pwd
sudo cp /etc/profile /etc/profile.ffmpegbackup
sudo tee -a /etc/profile << "EOF"
export PATH=$PATH:/monchickey/ffmpeg/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/monchickey/ffmpeg/lib
EOF
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "ffmpge用户变量添加成功"
echo "-----------------------------------------------------"
else
echo "-----------------------------------------------------"
echo "ffmpge用户变量添加失败"
echo "-----------------------------------------------------"
exit 0
fi
source /etc/profile

ffmpeg -version
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "ffmpge安装成功"
echo "-----------------------------------------------------"
else
echo "-----------------------------------------------------"
echo "ffmpge安装失败"
echo "-----------------------------------------------------"
exit 0
fi

echo "--------------步骤8：安装JDK-------------------------"
# 安装openjdk
cd /home/appium
echo "当前目录："
pwd

if test -d java
then
echo "-----------------------------------------------------"
echo "java文件夹已存在"
echo "-----------------------------------------------------"
rm -rf java/
mkdir java
else 
echo "-----------------------------------------------------"
echo "java文件夹不存在，创建java文件夹"
echo "-----------------------------------------------------"
mkdir java
fi
cd java
echo "当前目录："
pwd

wget https://download.java.net/java/GA/jdk18/43f95e8614114aeaa8e8a5fcf20a682d/36/GPL/openjdk-18_linux-x64_bin.tar.gz
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "wget-JDK完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]wget-JDK失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

tar -xvf openjdk-18_linux-x64_bin.tar.gz
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "tar-JDK完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]tar-JDK失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

sudo cp /etc/profile /etc/profile.jdkbackup
sudo tee -a /etc/profile << "EOF"
export JAVA_HOME=/home/appium/java/jdk-18
export CLASSPATH=.:/$JAVA_HOME/jre/lib/rt.jar:/$JAVA_HOME/lib/dt.jar:/$JAVA_HOME/lib/tools.jar
export PATH=/$PATH:/$JAVA_HOME/bin
EOF
source /etc/profile

java --version
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "JAVA-JDK安装完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]JAVA-JDK安装失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

echo "--------------步骤9：配置Python3环境----------------"
cd /home/appium
echo "当前目录："
pwd
sudo unlink /usr/bin/python
sudo ln -s /usr/bin/python3.8 /usr/bin/python
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "python软连接python3.8成功"
echo "-----------------------------------------------------"
else
echo "-----------------------------------------------------"
echo "python软连接python3.8失败"
echo "-----------------------------------------------------"
exit 0
fi
#sudo apt install pip
#if test $? = 0 
#then
#echo "-----------------------------------------------------"
#echo "安装pip成功"
#echo "-----------------------------------------------------"
#else
#echo "-----------------------------------------------------"
#echo "安装pip失败"
#echo "-----------------------------------------------------"
#exit 0
#fi

#pip install Appium-Python-Client
#if test $? = 0 
#then
#echo "-----------------------------------------------------"
#echo "安装Appium-Python-Client成功"
#echo "-----------------------------------------------------"
#else
#echo "-----------------------------------------------------"
#echo "安装Appium-Python-Client失败"
#echo "-----------------------------------------------------"
#exit 0
#fi

echo "--------------步骤10：安装appium---------------------"
cd /home/appium
echo "当前目录："
pwd
npm install -g appium
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "appium安装完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]appium安装失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

echo "--------------步骤10：安装mjpeg-consumer-------------"
cd /home/appium
echo "当前目录："
pwd
npm install -g mjpeg-consumer
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "mjpeg-consumer安装完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]mjpeg-consumer安装失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

echo "--------------步骤11：安装Android_SDK-------------------------"
# 安装Android_SDK
cd /home/appium
echo "当前目录："
pwd
if test -d Android_SDK
then
echo "-----------------------------------------------------"
echo "Android_SDK文件夹已存在"
echo "-----------------------------------------------------"
rm -rf Android_SDK/
mkdir Android_SDK
else 
echo "-----------------------------------------------------"
echo "Android_SDK文件夹不存在，创建Android_SDK文件夹"
echo "-----------------------------------------------------"
mkdir Android_SDK
fi
cd Android_SDK
echo "当前目录："
pwd

wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "wget-Android_SDK完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]wget-Android_SDK失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

tar -xvf android-sdk_r24.4.1-linux.tgz
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "tar-Android_SDK完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]tar-Android_SDK失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

echo "--------------步骤12：下载bundletool-------------------------"
# 下载bundletool
cd /home/appium/Android_SDK/android-sdk-linux
mkdir bundle-tool
cd bundle-tool
echo "当前目录："
pwd
wget https://github.com/google/bundletool/releases/download/1.9.1/bundletool-all-1.9.1.jar
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "wget-bundletool完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]wget-bundletool失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

mv bundletool-all-1.9.1.jar bundletool.jar
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "重命名-bundletool.jar成功"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]重命名-bundletool.jar失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi
chmod a+x bundletool.jar
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "赋权-bundletool.jar完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]赋权-bundletool.jar失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi

sudo cp /etc/profile /etc/profile.Android_SDKbackup
sudo tee -a /etc/profile << "EOF"
export ANDROID_HOME=/home/appium/Android_SDK/android-sdk-linux
export PATH=$PATH:$ANDROID_HOME/tools/:$ANDROID_HOME/platform-tools/:$ANDROID_HOME/bundle-tool/:$ANDROID_HOME/build-tools/29.0.3/:$PATH
EOF
source /etc/profile

echo "-----------------------------------------------------"
echo "调用Android_SDK管理工具，手动安装sdk、tools"
echo "-----------------------------------------------------" 
android
echo "-----------------------------------------------------"
echo "sdk、tools安装完成"
echo "-----------------------------------------------------" 



echo "--------------步骤13：安装appium-doctor--------------"
npm install -g appium-doctor
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "appium-doctor安装完成"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "[Error]appium-doctor安装失败，请手动输入命令查看"
echo "-----------------------------------------------------" 
exit 0
fi
echo "-----------------------------------------------------"
echo "调用appium-doctor，检查appium安装情况及依赖支持！"
echo "-----------------------------------------------------" 

appium-doctor
if test $? = 0 
then
echo "-----------------------------------------------------"
echo "检查appium安装情况及依赖支持！"
echo "-----------------------------------------------------"
else 
echo "-----------------------------------------------------"
echo "检查appium安装情况及依赖支持失败！"
echo "-----------------------------------------------------" 
exit 0
fi

echo "-----------------------------------------------------"
echo "启动appium！"
echo "-----------------------------------------------------"
appium