#!/bin/bash

echo "install php v 8.1"
echo "1"
apt-get install ca-certificates apt-transport-https software-properties-common -y
echo "2"
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list
echo "3"
wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add -
echo "4"
apt-get update -y
echo "5"
sudo apt-get install php8.1
php -v

echo "install symfony 5 "
curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash
sudo apt install symfony-cli
echo "install ngrok "
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok
ngrok config add-authtoken 2SyyW6K6p11TZsJtWHJhHjvkzjJ_7vFReCusa51dShz8tGfza
