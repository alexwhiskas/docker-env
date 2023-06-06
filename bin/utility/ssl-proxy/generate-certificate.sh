#!/bin/bash

[ -z "$1" ] && echo "Define domain name" && exit;
# uncomment line below and move usage of $2 param for multistore purpose
#[ -z "$2" ] && echo "Define subdomain name" && exit;

openssl req -x509 -newkey rsa:2048 \
    -keyout ./services/ssl-proxy/certificates/self-signed.key \
    -out ./services/ssl-proxy/certificates/self-signed.crt \
    -days 500 \
    -subj /C=AU/ST=DevEnv/L=London/O=DevEnv/CN=$1 \
    -nodes;

# move before "-nodes;" line for multistore purpose
#    -addext "subjectAltName=DNS:$1, DNS:$2" \
