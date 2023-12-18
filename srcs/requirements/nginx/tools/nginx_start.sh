#!/bin/bash

CERT_PATH="/etc/ssl/certs/nginx.crt"
KEY_PATH="/etc/ssl/private/nginx.key"

if [ ! -f "$CERT_PATH" ]; then
  echo "Nginx: SSL certificate not found. Setting up SSL..."
  openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
    -keyout "$KEY_PATH" -out "$CERT_PATH" \
    -subj "/C=BE/ST=BRUXELLES/L=BRUXELLES/O=42/OU=19/CN=localhost"
  echo "Nginx: SSL setup completed. Certificate: $CERT_PATH, Key: $KEY_PATH"
else
  echo "Nginx: SSL certificate found at $CERT_PATH. No need to set up SSL."
fi

exec "$@"
