# renewable-pv

To test it you can use [minikube](https://minikube.sigs.k8s.io/docs/start/) on your laptop.
```
minikube start --driver=docker
```

On a different terminal (that will automagically open up a browser with the k8s dashboard):
```
minikube dashboard
```

Then create the provisioner:
```
kubectl apply -f local-path-storage.yaml
```

Create the daq-app (fake) pods:
```
kubectl apply -f pvc_rancher_provided_pod.yaml
```

Lets write some "data" on the PVC (these are empty files with extension `hdf5`, or `hdf5.writing`, but you can obviously change that, this script is very very simple):
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
[wait for a while....]
```

Check the data on the host node (i.e. outside the cluster):
```
minikube ssh # this command puts you on the fake cluster of 1 node
ls -l /data?
[a list of empty files]
[ctrl-d]
```

When you are done:
```
minikube stop
```

## Extra bits
### Reusing the PV
You can now check that writing the recreating daq apps and writing will work:
```
kubectl apply -f pvc_rancher_provided_pod.yaml
write_pod.sh r6
write_pod.sh r7
write_pod.sh r1 # just for fun, let's see what happens when we want to overwrite a file...
```

Chuck the pods (again):
```
kubectl delete -f pvc_rancher_provided_pod.yaml
[whistle for a while...]
```

Check the data:
```
minikube ssh
ls -l /data?
[a list of empty files]
[ctrl-d]
```

### Bigger cluster
Make sure you have no cluster running by executing `minikube profile list` (`minikube stop` if you do).
Restart a bigger cluster:
```
minikube start --driver=docker --nodes=4
```

Now, some familiar commands:
```
kubectl apply -f local-path-storage-multinode.yaml
kubectl apply -f pvc_rancher_provided_pod.yaml
write_pod.sh r1
write_pod.sh r2
```

Start and stop them a couple of time, check that you can reuse the PV...
To check the data, you need to specify the correct node:
```
minikube ssh -n minikube-m02 # for example
ls -l /data?
[a list of empty files]
[ctrl-d]
```
