#!/bin/bash
exec > >(tee /var/log/startup.log) 2>&1
set -ex
sudo apt-get update
sudo apt-get install -y nginx
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/CN=localhost"
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
sudo mkdir -p /etc/nginx/snippets
cat <<EOF > /etc/nginx/snippets/self-signed.conf
ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
EOF
cat <<EOF > /etc/nginx/snippets/ssl-params.conf
ssl_protocols TLSv1.2;
ssl_prefer_server_ciphers on;
ssl_dhparam /etc/ssl/certs/dhparam.pem;
ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384;
ssl_ecdh_curve secp384r1; # Requires nginx >= 1.1.0
ssl_session_timeout  10m;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off; # Requires nginx >= 1.5.9
ssl_stapling on; # Requires nginx >= 1.3.7
ssl_stapling_verify on; # Requires nginx => 1.3.7
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;
add_header X-XSS-Protection "1; mode=block";
EOF
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
cat <<EOF > /etc/nginx/sites-available/default
server {
  listen 80 default_server;
  listen [::]:80 default_server;
  server_name _;
  location / {
    return 301 https://\$host\$request_uri;
  }
}
server {
  listen 443 ssl http2 default_server;
  listen [::]:443 ssl http2 default_server;
  server_name _;
  include snippets/self-signed.conf;
  include snippets/ssl-params.conf;
  location / {
    try_files \$uri \$uri/ =404;
  }
}
EOF
sudo systemctl restart nginx