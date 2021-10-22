#!/bin/sh

CLUSTER_NAME=$1
KAFKA_NAMESPACE=$2
KAFKA_USER_NAME=$3

if [ "$CLUSTER_NAME" = "applegreen" ]; then
  CONFIG_FILE=~/.kube/applegreen-cluster.yaml
elif [ "$CLUSTER_NAME" = "infradev" ]; then
  CONFIG_FILE=~/.kube/dcs-infra-dev-cluster.yaml
elif [ "$CLUSTER_NAME" = "multidev" ]; then
  CONFIG_FILE=~/.kube/multidev-cluster.yaml
elif [ "$CLUSTER_NAME" = "ti-staging" ]; then
  CONFIG_FILE=~/.kube/ti-staging.yaml
elif [ "$CLUSTER_NAME" = "walamb-iht-001" ]; then
  CONFIG_FILE=~/.kube/2376852-walamb-iht-001.yaml
elif [ "$CLUSTER_NAME" = "local" ]; then
  CONFIG_FILE=~/.kube/config
fi

kubectl --kubeconfig /home/nlsgand/.kube/dcs-infra-dev-cluster.yaml get secret kafka-cluster-ca-cert -n $KAFKA_NAMESPACE -o jsonpath='{.data.ca\.crt}' | base64 -d > ca.crt
keytool -import -trustcacerts -alias root -file ./ca.crt -keystore ./truststore.jks -storepass password -noprompt
kubectl --kubeconfig /home/nlsgand/.kube/dcs-infra-dev-cluster.yaml get secret $KAFKA_USER_NAME -n $KAFKA_NAMESPACE -o jsonpath='{.data.user\.crt}' | base64 -d > user.crt
kubectl --kubeconfig /home/nlsgand/.kube/dcs-infra-dev-cluster.yaml get secret $KAFKA_USER_NAME -n $KAFKA_NAMESPACE -o jsonpath='{.data.user\.key}' | base64 -d > user.key
openssl pkcs12 -export -in ./user.crt -inkey ./user.key -name $KAFKA_USER_NAME -password pass:1234567 -out ./user.p12
