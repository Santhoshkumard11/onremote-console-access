#!/bin/bash

touch ../pyth.py
cat > ../pyth.py <<EOF
import subprocess 
subprocess.call(['./run.sh'])
EOF

touch ../run.sh
cat > ../run.sh <<EOF
#!/bin/bash
sudo ttyd -o ./picocom -b 9600 /dev/ttyUSB0
EOF

cp picocom /usr/local/bin
rm ../install