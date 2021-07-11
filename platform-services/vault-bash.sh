#!/bin/bash

kubectl -n vault exec vault-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > vault-0-cluster-keys.json

VAULT0_UNSEAL_KEY=$(cat vault-0-cluster-keys.json | jq -r ".unseal_keys_b64[]")

kubectl -n vault exec vault-0 -- vault operator unseal $VAULT0_UNSEAL_KEY

#kubectl -n vault exec vault-1 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > vault-1-cluster-keys.json


#VAULT1_UNSEAL_KEY=$(cat vault-1-cluster-keys.json | jq -r ".unseal_keys_b64[]")

#kubectl -n vault exec vault-1 -- vault operator unseal $VAULT1_UNSEAL_KEY

kubectl -n vault exec vault-1 -- vault operator unseal $VAULT0_UNSEAL_KEY
