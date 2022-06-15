#!/bin/sh

echo "Writing PVC-1 pod"
kubectl exec -n daq -it pvc-1 -- touch /mnt/storage/pvc-1-${1}.hdf5

echo "Writing PVC-2 pod"
kubectl exec -n daq -it pvc-2 -- touch /mnt/storage/pvc-2-${1}.hdf5.writing

./ls_pods.sh
