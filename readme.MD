## (alt. 1) Workshop using Gitpod
Gitpod is a developer-environment-as-a-service and this workspace is configure with:
* gcloud SDK
* kubectlx/kubens
* Vscode extensions and other things needed for the workshop 

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/nordineb/k8s2020/tree/master/into-kubernetes)

Connecting to our GKE cluster :
1. gcloud auth login
2. gcloud config set project xxxxxx
3. gcloud container clusters get-credentials xxxxxx --zone xxxxxx

## (alt. 2) Workshop using Google Cloud Shell Editor
No need for configuration

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ssh.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nordineb/k8s2020.git)

## References for the workshop
https://kubernetes.io/docs/reference/kubectl/cheatsheet/

```
kubectl run --help
kubectl api-resources
kubectl api-versions
kubectl explain pods
kubectl explain pods.spec.containers.imagePullPolicy
kubectl explain pods --recursive
```

## [Optional] Shell aliases
```
alias k=kubectl
alias kgp='k get po'
alias kdp='k delete po --force --grace-period=0'
alias kaf='k apply -f'
alias kdf='k delete -f'
alias kex='k explain'
alias ker='k explain --recursive'
```
Autocompletion:
https://kubernetes.io/docs/tasks/tools/install-kubectl/#enable-kubectl-autocompletion

## Getting started

👉 First thing to do is to switch to your own namespace. Don't use default default or one of the system namespaces 😅
```
kubectl create namespace nordine
kubens nordine
```

Investigating `kubectl`
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

`kubectl run`
```
kubectl run hello-app --image=gcr.io/google-samples/hello-app:1.0
kubectl get pod -o wide
kubectl describe pod hello-app
kubectl exec --stdin --tty hello-app -- wget -O- localhost:8080
kubectl exec --stdin --tty hello-app -- /bin/sh
kubectl delete pod hello-app
```

Export objects to YAML
```
kubectl run hello-app --image=gcr.io/google-samples/hello-app:1.0
kubectl get pod hello-app-nordine -o yaml
```

Scaffold YAML
```
kubectl run hello-app --image=gcr.io/google-samples/hello-app:1.0  --dry-run=client -o yaml > mypod.yaml 
kubectl apply -f mypod.yml
```

'kubectl apply' vs 'kubectl create'
Use apply


Clean up
```
kubectl delete pod hello-app
```

## Create and configure deployments

### Replicasets 
```
kubectl apply -f k-deployment/replicaset-yaml
```
Pods are recreated when they crash or are deleted
### Scaling 
```
kubectl scale --current-replicas=1 --replicas=3 rs/frontend
```

### Deployments
```
kubectl create deployment hello-app --image=gcr.io/google-samples/hello-app:1.0 --replicas=1
```
👉 Notice how a replicaset was created
👉 Deployment can be scaled with:
```
kubectl scale --current-replicas=1 --replicas=3 deployment/hello-app
```

Inspecting deployments
```
kubectl describe deployment hello-app
kubectl logs deployment/hello-app  
kubectl get pods -o wide
kubectl get pods
```

## Create and configure services
```
kubectl expose deployment hello-app --type=NodePort --name=hello-app-nodeport --port 8080
kubectl describe services hello-app-nodeport

kubectl expose deployment hello-app --type=LoadBalancer --name=hello-app-lb --port 80  --target-port=8080
kubectl describe services hello-app-lb
```

## Limits/Quota
```
k run nginx  --image=nginx --replicas=3 --requests=cpu=0.100,memory=100Mi --limits=cpu=0.2,memory=100Mi
```

## Secrets

Configmaps & Secrets reside in a namespace and can only be referenced by Pods in that same namespace. Sync configmaps and secrets manually og use https://github.com/contentful-labs/kube-secret-syncer

```
kubectl get secret|configmap <name>  --namespace=<source-namespace> --export -o yaml | kubectl apply --namespace=<destination-namespace> -f -
```

```
kubectl create configmap my-config --from-literal=PORT=8081 --from-literal=ENABLE_LOGGING=1

kubectl create secret generic prod-db-secret --from-literal=DB_USERNAME=admin --from-literal=DB_PASSWORD=Pass@Word2021!
kubectl describe secret prod-db-secret

kubectl apply -f pod-.yaml

kubectl exec --stdin --tty hello-app-nordine -- /bin/sh


```
## Volumes
```
kubectl apply -f pvc.yaml
kubectl apply -f pod-volume-demo.yaml
kubectl exec --stdin --tty hello-app -- /bin/sh
```

## Create and configure Jobs and CronJobs
```
k run job --dry-run=client -o yaml --image=busybox --restart=OnFailure -- /bin/sh -c "sleep 4800" 

kubectl create cronjob nordine-cronjob --dry-run=client -o yaml --image=busybox --restart=OnFailure --schedule="*/1 * * * *" -- date 
```

## SecurityContexts
```
kubectl apply -f securitycontext.yaml
```



