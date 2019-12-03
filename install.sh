#!/bin/bash
# sudo apt install build-essential

# sudo apt -y install software-properties-common
# sudo add-apt-repository ppa:george-edison55/cmake-3.x
# sudo apt -y update
# sudo apt -y install cmake
# sudo apt-get install netdiscover

# sudo apt -y install libwebsockets-dev g++ pkg-config git vim-common libjson-c-dev libssl-dev
# git clone https://github.com/tsl0922/ttyd.git
# cd ttyd && mkdir build && cd build
# cmake ..
# sudo make && make install
# sudo cp ttyd /usr/local/bin/ttyd
# cd 

# PORT="$(dmesg | grep 'pl2303 converter now attached to' | grep -o 'tty.*')"

touch run_console
cat > run_console <<EOF
#!/bin/bash
sudo kill -9 $(ps aux | grep 'ttyd' | awk '{print $2}')
PORT="$(dmesg | grep 'pl2303 converter now attached to' | grep -o 'tty.*')"
sudo ttyd -o picocom -b 9600 /dev/$PORT
EOF

sudo chmod +x run_console
sudo mv run_console /usr/local/bin

# wget https://github.com/archetype2142/onremote-console-access/raw/master/picocom
# sudo chmod +x picocom 
# sudo mv picocom /usr/local/bin
# sudo rm -rv ttyd
rm -- "$0"
