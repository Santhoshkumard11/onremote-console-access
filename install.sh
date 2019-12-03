#!/bin/bash
sudo apt install build-essential

sudo apt -y install software-properties-common
sudo add-apt-repository ppa:george-edison55/cmake-3.x
sudo apt -y update
sudo apt -y install cmake

sudo apt -y install g++ pkg-config git vim-common libwebsockets-dev libjson-c-dev libssl-dev
git clone https://github.com/tsl0922/ttyd.git
cd ttyd && mkdir build && cd build
cmake ..
sudo make && make install
sudo cp ttyd /usr/local/bin/ttyd
cd ~/onremote-console-access/

touch ../run.sh
cat > ../run.sh <<EOF
#!/bin/bash
sudo ttyd -o picocom -b 9600 /dev/ttyUSB0
EOF

sudo chmod +x ../run.sh

sudo cp picocom /usr/local/bin
sudo rm -rv $(pwd)
