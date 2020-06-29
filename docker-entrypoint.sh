#!/bin/sh
set -eu

if [ -n "$KEY_FILE" ] && [ -n "$CERT_FILE" ] && [ -n "$CA_FILE" ]; then
  method='run'
  lego_path=/var/lib/lego

  while true; do
    [ -f $lego_path/certificates/$LETSENCRYPT_DOMAIN.crt ] && method='renew'

    lego_server_params=''
    if [ -n "$LETSENCRYPT_SERVER" ]; then
      lego_server_params="--server=$LETSENCRYPT_SERVER"
    fi

    lego \
      --path=/var/lib/lego \
      $lego_server_params \
      --email="$LETSENCRYPT_EMAIL" \
      --domains="$LETSENCRYPT_DOMAIN" \
      --http --accept-tos $method

    cp $lego_path/certificates/$LETSENCRYPT_DOMAIN.issuer.crt $CA_FILE
    cp $lego_path/certificates/$LETSENCRYPT_DOMAIN.crt        $CERT_FILE
    cp $lego_path/certificates/$LETSENCRYPT_DOMAIN.key        $KEY_FILE

    sleep 1d
  done
fi
