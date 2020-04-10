mkdir temp_ssl
cd temp_ssl
touch run_console
cat > run_console <<EOF
#!/bin/bash
sudo pkill ttyd

sudo ttyd --ssl --ssl-cert "/usr/local/bin/server.crt" --ssl-key "/usr/local/bin/server.key" picocom2 -b 9600 /dev/$(dmesg | grep 'pl2303 converter now attached to' | grep -o 'tty.*')
EOF
sudo chmod +x run_console

openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 365 -key ca.key -subj "/C=IN/ST=UP/L=Noida/O=nexzstep/CN=nexzstep CA" -out ca.crt

# server certificate (for multiple domains, change subjectAltName to: DNS:example.com,DNS:www.example.com)
openssl req -newkey rsa:2048 -nodes -keyout server.key -subj "/C=IN/ST=UP/L=Noida/O=nexzstep/CN=$1" -out server.csr
openssl x509 -sha256 -req -extfile <(printf "subjectAltName=DNS:$(exec hostname -I | awk '{print $2}' )") -days 365 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt

sudo mv * /usr/local/bin/
rm -rv temp_ssl/
rm reconfig_console.sh
