#!/bin/bash

[ -z "$1" ] && echo "Define domain name" && exit;

openssl req -x509 -newkey rsa:2048 \
    -keyout ./services/ssl-proxy/certificates/self-signed.key \
    -out ./services/ssl-proxy/certificates/self-signed.crt \
    -days 500 \
    -subj /C=AU/ST=DevEnv/L=Melbourne/O=DevEnv/CN=$1 \
    -nodes;
