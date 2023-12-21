FROM ubuntu:latest
WORKDIR /root/pico

RUN sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list && \
    sed -i s@/security.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list && \
    sed -i s@/ports.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list && \
    apt-get clean && \
    apt-get update && \
    apt-get full-upgrade -y && \
    rm -rf /var/lib/apt/lists/*

ENV TZ=Asia/Chongqing
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cmake gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential \
    libstdc++-arm-none-eabi-newlib \
    minicom \
    automake autoconf texinfo libtool libftdi-dev libusb-1.0-0-dev \
    gdb-multiarch \
    pkg-config \
    wget git usbutils python3-pip python3-tk && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install rshell

RUN git clone https://github.com/raspberrypi/pico-sdk.git --branch master && \
    cd pico-sdk && \
    git submodule update --init && \
    cd .. && \
    git clone https://github.com/raspberrypi/pico-examples.git --branch master && \
    git clone https://github.com/raspberrypi/pico-extras.git --branch master && \
    git clone https://github.com/raspberrypi/pico-playground.git --branch master && \
    git clone https://github.com/raspberrypi/pico-project-generator.git --branch master

RUN echo 'export PICO_SDK_PATH=/root/pico/pico-sdk' >> /root/.bashrc && \
    echo 'export PICO_EXAMPLES_PATH=/root/pico/pico-examples' >> /root/.bashrc && \
    echo 'export PICO_EXTRAS_PATH=/root/pico/pico-extras' >> /root/.bashrc && \
    echo 'export PICO_PLAYGROUND_PATH=/root/pico/pico-playground' >> /root/.bashrc && \
    echo 'export PATH=$PATH:/root/pico/pico-project-generator' >> /root/.bashrc

RUN git clone https://github.com/raspberrypi/openocd.git --branch rp2040 --recursive --depth=1 && \
    cd openocd && \
    ./bootstrap && \
    ./configure --enable-ftdi --enable-sysfsgpio --enable-bcm2835gpio && \
    make -j4 && \
    make install && \
    cd ..

RUN git clone https://github.com/raspberrypi/picotool.git --branch master && \
    cd picotool && \
    mkdir build && \
    cd build && \
    export PICO_SDK_PATH=/root/pico/pico-sdk && \
    cmake ../ && \
    make && \
    make install && \
    cd ..
