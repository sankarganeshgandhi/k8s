#!/bin/bash

# 1. infradev
# 2. multidev
# 3. local
#
CLUSTER_NAME=$1
NAMESPACE=$2
VAULT_INIT=$3

if [ "$CLUSTER_NAME" = "infradev" ]; then
  CONFIG_FILE=~/.kube/dcs-infra-dev-cluster.yaml
  KEYS_FILE_NAME=infradev-vault-keys.json
elif [ "$CLUSTER_NAME" = "multidev" ]; then
  CONFIG_FILE=~/.kube/multidev-cluster.yaml
  KEYS_FILE_NAME=multidev-vault-keys.json
elif [ "$CLUSTER_NAME" = "local" ]; then
  CONFIG_FILE=~/.kube/config
  KEYS_FILE_NAME=local-vault-keys.json
fi

#kubectl -n vault exec vault-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > vault-0-cluster-keys.json

#VAULT0_UNSEAL_KEY=$(cat vault-0-cluster-keys.json | jq -r ".unseal_keys_b64[]")

#kubectl -n vault exec vault-0 -- vault operator unseal $VAULT0_UNSEAL_KEY

#kubectl -n vault exec vault-1 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > vault-1-cluster-keys.json


#VAULT1_UNSEAL_KEY=$(cat vault-1-cluster-keys.json | jq -r ".unseal_keys_b64[]")

#kubectl -n vault exec vault-1 -- vault operator unseal $VAULT1_UNSEAL_KEY

#kubectl -n vault exec vault-1 -- vault operator unseal $VAULT0_UNSEAL_KEY

if [ "$VAULT_INIT" = "init" ]; then
  kubectl --kubeconfig $CONFIG_FILE -n $NAMESPACE exec vault-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > $KEYS_FILE_NAME
fi
VAULT_UNSEAL_KEY=$(cat $KEYS_FILE_NAME | jq -r ".unseal_keys_b64[]")
kubectl --kubeconfig $CONFIG_FILE -n $NAMESPACE exec vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY
kubectl --kubeconfig $CONFIG_FILE -n $NAMESPACE exec vault-1 -- vault operator unseal $VAULT_UNSEAL_KEY
