---
layout: post
title: shell script
date: 2011-01-01
tag: shell
---

# kube build
```
#!/usr/bin/env bash
export K8S_VERSION = v1.13.3
git clone https://github.com/kubernetes/kubernetes.git $GOPATH/src/k8s.io/
git fetch --all
git checkout tags/$K8S_VERSION -b v$K8S_VERSION
export ETCD_HOST=192.168.1.9
export KUBE_INTEGRATION_ETCD_URL=http://$ETCD_HOST:2379
cd $GOPATH/src/k8s.io/kubernetes/build/
bash -x ./run.sh make > run.log 2>&1
```

# kube image pull then tag
```
#!/usr/bin/env bash
docker pull  mirrorgooglecontainers/kube-apiserver:v1.13.3
docker pull  mirrorgooglecontainers/kube-controller-manager:v1.13.3
docker pull  mirrorgooglecontainers/kube-scheduler:v1.13.3
docker pull  mirrorgooglecontainers/kube-proxy:v1.13.3
docker pull  mirrorgooglecontainers/pause:3.1
docker pull  mirrorgooglecontainers/etcd:3.2.24
docker pull  coredns/coredns:1.2.6
docker tag  mirrorgooglecontainers/kube-apiserver:v1.13.3 k8s.gcr.io/kube-apiserver:v1.13.3
docker tag  mirrorgooglecontainers/kube-controller-manager:v1.13.3          k8s.gcr.io/kube-controller-manager:v1.13.3
docker tag  mirrorgooglecontainers/kube-scheduler:v1.13.3 k8s.gcr.io/kube-scheduler:v1.13.3
docker tag  mirrorgooglecontainers/kube-proxy:v1.13.3 k8s.gcr.io/kube-proxy:v1.13.3
docker tag  mirrorgooglecontainers/pause:3.1 k8s.gcr.io/pause:3.1
docker tag  mirrorgooglecontainers/etcd:3.2.24 k8s.gcr.io/etcd:3.2.24
docker tag  coredns/coredns:1.2.6 k8s.gcr.io/coredns:1.2.6

```

# prepare kubelet for kubeadm deploy

```
cd build
run.sh make
scp ~/go/src/k8s.io/kubernetes/_output/dockerized/bin/linux/amd64/kube???  vm1:~/
```


kubeadm-deploy.sh
```
#!/usr/bin/env bash
scp ~/go/src/k8s.io/kubernetes/build/debs/kubelet.service vm1:~/
scp ~/go/src/k8s.io/kubernetes/build/debs/10-kubeadm.conf vm1:~/
cat << EOF > kubelet-service.sh
#!/usr/bin/env bash
sudo cp ~/kubelet.service /etc/systemd/system/kubelet.service
sudo mkdir -p /etc/kubernetes/manifests
sudo mkdir -p /etc/systemd/system/kubelet.service.d/
sudo cp ~/10-kubeadm.conf /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
sudo systemctl daemon-reload
sudo systemctl enable kubelet --now
sudo systemctl start kubelet
EOF
# execute the local script on the remote server
ssh vm1 'bash -s' < kubelet-service.sh
rm kubelet-service.sh
```
