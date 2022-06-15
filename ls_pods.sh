#!/bin/sh
echo "PVC-1 pod content:"
kubectl exec -n daq -it pvc-1 -- ls -l /mnt/storage

echo "PVC-2 pod content:"
kubectl exec -n daq -it pvc-2 -- ls -l /mnt/storage
