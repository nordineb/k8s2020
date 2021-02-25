[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/nordineb/k8s2020/tree/master/into-kubernetes)

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ssh.cloud.google.com/cloudshell/editor?cloudshell_git_repo=http://path-to-repo/sample.git)


## Gitpod
Gitpod is a developer-environment-as-a-service and this workspace is configure with:
* gcloud SDK
* kubectlx/kubens
* other stuff that we need for the workshop
* All the vscode settings needed for the workshop 

More information here:
[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/nordineb/k8s2020)

## Connecting to our GKE cluster 
1. gcloud auth login
2. gcloud config set project k8s2021
3. gcloud container clusters get-credentials prod-cluster --zone europe-west3-a
4. kubectl create namespace nordine
5. kubens nordine

Note: All nodes have public IPs and ports 30000-32767 are open so that we can demonstrate nodePort type

## Getting help
```
kubectl run --help
https://kubernetes.io/docs/reference/kubectl/cheatsheet/

kubectl api-resources
kubectl api-versions
kubectl explain pods
kubectl explain pods.spec.containers.imagePullPolicy
kubectl explain pods --recursive
```

## Alias 
```
alias k=kubectl
alias kgp='k get po'
alias kdp='k delete po --force --grace-period=0'
alias kaf='k apply -f'
alias kdf='k delete -f'
alias kex='k explain'
alias ker='k explain --recursive'
```

## VIM setup
```
vi ~/.vimrc
set ts=2 sts=2 sw=2 et number
```

## Inspecting resources
```
kubectl get pod
kubectl get pod -A
kubectl get services
kubectl get svc -A
kubectl get nodes -o wide
kubectl top pod -A
kubectl top node
kubectl describe pods
```

## Create and configure pods
```
kubectl create hello-app-nordine --image=gcr.io/google-samples/hello-app:1.0
kubectl get pod -o wide
kubectl describe pod nordinedep
kubectl delete pod hello-app-nordine

kubectl run hello-app-nordine --image=gcr.io/google-samples/hello-app:1.0
kubectl get pod hello-app-nordine -o yaml > mypod.yml

kubectl run hello-app-nordine --image=gcr.io/google-samples/hello-app:1.0  --dry-run=client -o yaml > mypod.yaml 
kubectl apply -f mypod.yml
```
## Create and configure deployments
```
kubectl create deployment nordinedep --image=gcr.io/google-samples/hello-app:1.0 --replicas=1
kubectl describe deployment nordinedep
kubectl logs deployment/nordinedep    
kubectl get pods -o wide
kubectl delete pod nordinedep-54f48f5865-tdzx8
kubectl get pods
```
## scaling 
```
kubectl scale --current-replicas=1 --replicas=3 deployment/nordinedep
```

## Replicasets 
```
kubectl apply -f replicaset-yaml
```

## Create and configure services
```
kubectl expose deployment nordinedep --type=NodePort --name=nordine-service --port 8080
kubectl describe services nordine-service

kubectl expose deployment nordinedep --type=LoadBalancer --name=nordine-servicelb --port 80
kubectl describe services nordine-servicelb
```

### Deployments, rolling updates, rollbacks

## Create and configure Jobs and CronJobs
```
k run job --dry-run=client -o yaml --image=busybox --restart=OnFailure -- /bin/sh -c "sleep 4800" 

kubectl create cronjob nordine-cronjob --dry-run=client -o yaml --image=busybox --restart=OnFailure --schedule="*/1 * * * *" -- date 
```

## ConfigMaps
```
kubectl create configmap my-config --from-literal=key1=config1 --from-literal=key2=config2
kubectl get configmap my-config 
kubectl describe configmaps my-config
```

## Secrets
```
kubectl create secret generic my-secret --from-literal=key1=supersecret --from-literal=key2=topsecret
kubectl describe secret my-secret

```
## Volumes
```
kubectl apply -f volume.yaml
```

## SecurityContexts
```
kubectl apply -f securitycontext.yaml
```

## Limits/Quota
```
k run nginx  --image=nginx --replicas=3 --requests=cpu=0.100,memory=100Mi --limits=cpu=0.2,memory=100Mi
```




