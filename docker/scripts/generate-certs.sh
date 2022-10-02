#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/../certs"

# SEE: https://github.com/BenMorel/dev-certificates
# Generate private key to become a local Certificate Authority
# Need to be generated only once
if [ ! -f "ca.key" ]; then
    openssl genrsa -out ca.key 2048
    openssl req -x509 -new -nodes -subj "/C=US/O=_Development CA/CN=Development certificates" -key ca.key -days 3650 -out ca.crt -sha256
fi

set -a
source ../../.env
set +a

# Generate a private key
openssl genrsa -out "$DOMAIN.key" 2048

# Create a certificate signing request
openssl req -new -subj "/C=US/O=Local Development/CN=$DOMAIN" -key "$DOMAIN.key" -out "$DOMAIN.csr"

# Create a config file for the extensions
cat >"$DOMAIN.ext" <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth, clientAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = $DOMAIN
EOF

# Create the signed certificate
openssl x509 -req \
    -in "$DOMAIN.csr" \
    -extfile "$DOMAIN.ext" \
    -CA ca.crt \
    -CAkey ca.key \
    -CAcreateserial \
    -out "$DOMAIN.crt" \
    -days 365 \
    -sha256

rm "$DOMAIN.csr"
rm "$DOMAIN.ext"

echo -e "\e[42mSuccess!\e[49m"
echo -e "Don't forget that \e[1myou must have imported \e[93mca.crt\e[39m in your browser\e[0m to make it accept the certificate."
