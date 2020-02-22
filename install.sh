# !/bin/bash
sudo apt install build-essential

sudo apt -y install software-properties-common
sudo add-apt-repository ppa:george-edison55/cmake-3.x
sudo apt -y update
sudo apt -y install cmake
sudo apt-get install netdiscover
sudo apt -y install openvpn

sudo apt -y install libwebsockets-dev g++ pkg-config git vim-common libjson-c-dev libssl-dev
git clone https://github.com/tsl0922/ttyd.git
cd ttyd && mkdir build && cd build
cmake ..
sudo make && make install
sudo cp ttyd /usr/local/bin/ttyd
cd 

PORT="$(dmesg | grep 'pl2303 converter now attached to' | grep -o 'tty.*')"

touch run_console
cat > run_console <<EOF
#!/bin/bash
sudo pkill ttyd

PORT="$(dmesg | grep 'pl2303 converter now attached to' | grep -o 'tty.*')"
sudo ttyd -o picocom2 -b 9600 /dev/$PORT
EOF

sudo chmod +x run_console
cd
sudo mv run_console /usr/local/bin/

wget https://github.com/archetype2142/onremote-console-access/raw/master/picocom2
sudo chmod +x picocom2
sudo mv picocom2 /usr/local/bin
sudo rm -rv ttyd
rm -- "$0"
