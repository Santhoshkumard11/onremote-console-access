touch run_console
cat > run_console <<EOF
#!/bin/bash
sudo pkill ttyd

sudo ttyd picocom -b 9600 /dev/$(dmesg | grep 'pl2303 converter now attached to' | grep -o 'tty.*')
EOF
sudo chmod +x run_console
cd
sudo mv run_console /usr/local/bin/

rm -- "$0"
