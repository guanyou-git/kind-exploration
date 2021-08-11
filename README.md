# kind-exploration
kubernetes in docker quickstart


## To setup kind

1. shift kind binary to /usr/local/bin and make it executable
```
user@computer:~/$ cp kind /usr/local/bin
user@computer:~/$ chmod +x /usr/local/bin/kind
user@computer:~/$ kind -h
```

2. customize kind config by editing kind-config.yaml [1 worker used instead as multi-node cluster does not work after node/docker restart due to reassigning of node ip address]

3. start the kind cluster and check status
```
user@computer:~/$ kind create cluster --config=kind-config.yaml --image kindest/node:v1.20.7@sha256:cbeaf907fc78ac97ce7b625e4bf0de16e3ea725daf6b04f930bd14c67c671ff9
Creating cluster "kind" ...
 ✓ Ensuring node image (kindest/node:v1.20.7) 🖼
 ✓ Preparing nodes 📦 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
 ✓ Joining worker nodes 🚜
Set kubectl context to "kind-kind"
You can now use your cluster with:

kubectl cluster-info --context kind-kind

Thanks for using kind! 😊
user@computer:~/$ kubectl cluster-info --context kind-kind
user@computer:~/$ kubectl get nodes
user@computer:~/$ docker ps -a
```

4. setup namespaces, ingress and metallb
```
user@computer:~/$ kubectl apply -f ./namespace.yaml
user@computer:~/$ kubectl apply -f ./ingress/ingress-nginxdeploy.yaml
user@computer:~/$ ./metallb/metallb_secret.sh
user@computer:~/$ kubectl apply -R -f ./metallb/
```

5. setup nfs
```
user@computer:~/$ yum install nfs-utils rpcbind
user@computer:~/$ systemctl enable nfs-server
user@computer:~/$ systemctl enable rpcbind
user@computer:~/$ systemctl enable nfs-lock
user@computer:~/$ systemctl enable nfs-idmap
user@computer:~/$ systemctl start rpcbind
user@computer:~/$ systemctl start nfs-server
user@computer:~/$ systemctl start nfs-lock
user@computer:~/$ systemctl start nfs-idmap
user@computer:~/$ systemctl status nfs
user@computer:~/$ mkdir /home/nfs
user@computer:~/$# vi /etc/exports
/home/nfs *(rw)
user@computer:~/$ exportfs -r
```
