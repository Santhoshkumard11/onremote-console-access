touch run_console
cat > run_console <<EOF
#!/bin/bash
sudo pkill ttyd

PORT="$(dmesg | grep 'pl2303 converter now attached to' | grep -o 'tty.*')"
sudo ttyd -o picocom -b 9600 /dev/$PORT
EOF
sudo chmod +x run_console
cd
sudo mv run_console /usr/local/bin/

rm -- "$0"