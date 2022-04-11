#!/bin/bash

# 1. infradev
# 2. multidev
# 3. local
#
CLUSTER_NAME=$1
NAMESPACE=$2
SNAPSHOT_CLASS=$3

if [ "$CLUSTER_NAME" = "infradev" ]; then
  CONFIG_FILE=~/.kube/dcs-infra-dev-cluster.yam
elif [ "$CLUSTER_NAME" = "multidev" ]; then
  CONFIG_FILE=~/.kube/multidev-cluster.yam
elif [ "$CLUSTER_NAME" = "local" ]; then
  CONFIG_FILE=~/.kube/config
fi

for pvc in $(kubectl --kubeconfig $CONFIG_FILE -n $NAMESPACE get pvc | awk '{print $2}')
do

cat <<EOF | kubectl create -f -
apiVersion: snapshot.storage.k8s.io/v1alpha1
kind: VolumeSnapshot
metadata:
  name: ${pvc}-snapshot
  namespace: ${NAMESPACE}
spec:
  snapshotClassName: ${SNAPSHOT_CLASS}
  source:
    name: ${pvc}
    kind: PresistentVolumeClaim
EOF

done