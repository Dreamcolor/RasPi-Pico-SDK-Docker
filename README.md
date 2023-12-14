# RasPi-Pico-SDK-Docker

Raspberry Pi Pico SDK Container and make your system clean.

为了方便 Raspberry Pi Pico 开发环境的部署，现将开发所需的环境制作成了 Docker Container 镜像。

部署方式可以根据自己的需求进行选择。

## 镜像介绍：

本镜像构建脚本和已经创建完毕的镜像实现了如下功能：

* 在 /root 目录下创建 pico 目录
* 开发和构建软件所需要的所有依赖组件
* 下载 pico-sdk，pico-examples，pico-extras 和 pico-playground 代码
* 在 ~/.bashrc 中设置 PICO_SDK_PATH，PICO_EXAMPLES_PATH，PICO_EXTRAS_PATH 和 PICO_PLAYGROUND_PATH 环境变量
* 下载、构建并安装 picotool 软件
* 下载、构建并安装 OpenOCD 软件
* 附加下载 usbutils 及 [Getting started with Raspberry Pi Pico](https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf?_gl=1*lh1tgu*_ga*MTE5NDA3NjE3Mi4xNzAyMTIzNTYz*_ga_22FD70LWDS*MTcwMjUyMTI5NS4xMy4xLjE3MDI1MjIzMDQuMC4wLjA.) 中提及到的所有软件，方便各位的使用。

## 使用方法：

### 自行构建：

#### 方法 1：

在 Dockerfile 文件所在目录执行：docker build . --no-cache --tag `<username>`/`<image-name>`

然后运行：`docker run -it --privileged --name <Container-name> -v <local-dir>:/root/pico/projects <image-name>`

#### 方法 2：

将 docker-compose.yml 文件中 image: 行注释，并将 build: . 取消注释。（注意行首缩进！！！）

然后运行：`docker compose up -d`

#### 方法 3：

用你自己的方法让 Container 运行起来！^_^||

### 简易使用：

下载此 git 文件到你喜欢的目录，然后直接运行 `docker compose up -d` 命令。

### 注意事项：

* 本脚本会在镜像中的 /root/pico/ 目录中创建 projects 目录用于存放您开发的项目。并且默认会将目录映射到脚本所在目录的 projects 目录中。
* 如果想修改此目录，可以对脚本文件或以上“方法 1”中的 `<local-dir>` 位置进行修改。
* 如果构建镜像时想修改更新源，可以将 Dockerfile 文件中注释部分进行修改，并更换成您喜欢的更新源。

### 代码编写：

编写代码需要使用 VS Code。并且需要安装 Dev Container 相关扩展以及 [Getting started with Raspberry Pi Pico](https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf?_gl=1*lh1tgu*_ga*MTE5NDA3NjE3Mi4xNzAyMTIzNTYz*_ga_22FD70LWDS*MTcwMjUyMTI5NS4xMy4xLjE3MDI1MjIzMDQuMC4wLjA.) 中提及到的相关扩展。

说明文档目前还在完善中，如果有任何疑问，可以给我留言。如果您不是中文用户，可以暂时尝试使用翻译软件查看说明，或者先看下构建脚本文件内的代码，也许您就知道咋用了。

Happy Coding！！！
