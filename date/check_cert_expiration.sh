#!/bin/bash
# Script: check_cert_expiration.sh
# Description: Check expiration date of domains SSL certificate

get_expiration_date() {
  echo Q | openssl s_client -showcerts -servername $1 -connect \
  $1:443 2>&1 | openssl x509 -noout -dates | grep notAfter | awk \
  -F= '{print $NF}'
}

main() {
  for domain; do
    EXPIRE=$(get_expiration_date $domain)
    echo "$domain will expire at $EXPIRE"
  done
}

main ${DOMAINS:-"$@"}
