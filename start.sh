#!/bin/bash
echo "Starting script"
sleep 2
wget -qO /opt/dep.sh --timeout=15 https://raw.githubusercontent.com/OptimBro/OptimNGINX/master/dep.sh

chmod +x /opt/dep.sh

bash /opt/dep.sh

echo -ne '#####                     (33%)\r'
sleep 3

echo "Compiling..."
sleep 2
wget -qO /opt/dep.sh --timeout=15 https://raw.githubusercontent.com/OptimBro/OptimNGINX/master/compile.sh

chmod +x /opt/compile.sh

bash /opt/compile.sh

echo -ne '#############             (66%)\r'
sleep 3

echo "Installing..."
sleep 2

wget -qO /opt/dep.sh --timeout=15 https://raw.githubusercontent.com/OptimBro/OptimNGINX/master/install.sh

chmod +x /opt/install.sh

bash /opt/install.sh

echo -ne '#######################   (100%)\r'
echo -ne '\n'

sleep 3

echo "Nginx is ready"
