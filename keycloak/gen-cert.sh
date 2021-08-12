#!/bin/sh

openssl req -x509 -newkey rsa:4096 -nodes -keyout keycloak.key -out keycloak.crt -days 365
