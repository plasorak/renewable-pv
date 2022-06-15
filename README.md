# renewable-pv


To test it you can use minikube on your laptop.
```
minikube start --driver=docker
```

Then create the provisioner:
```
kubectl apply -f local-path-storage.yaml
```

Then create the daq-app (fake) pods:
```
kubectl apply -f pvc_rancher_provided_pod.yaml
```


Lets write some data to it:
```
write_pod.sh r1
write_pod.sh r2
write_pod.sh r3
write_pod.sh r4
write_pod.sh r5
```

Chuck the pods:
```
kubectl delete -f pvc_rancher_provided_pod.yaml
```

Check the data:
```
minikube ssh
ls -l /data?
[ctrl-d]
```
## Extra bits
You can now check that writing the recreating daq apps and writing will work:
```
kubectl apply -f pvc_rancher_provided_pod.yaml
write_pod.sh r6
write_pod.sh r7
write_pod.sh r1# just for fun let's see what happens when we want to overwrite a file...
```

Chuck the pods (again):
```
kubectl delete -f pvc_rancher_provided_pod.yaml
```

Check the data:
```
minikube ssh
ls -l /data?
[ctrl-d]



