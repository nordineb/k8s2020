## Run gcloud SDK in a docker container and run kubectl
```
docker volume create gcloudbekkops
docker run -it --rm -v gcloudbekkops:/root/.config/gcloud google/cloud-sdk
gcloud auth login
  
gcloud config set project k8s2021
gcloud container clusters get-credentials k8s2021 --region europe-west3-c

kubectl create namespace your-name-here
kubectl get namespaces
exit
```
👉 Credentials are now stored on the volume and can be shared

## Create a customer docker image from gcloud SDK 
👉 instructions in the folder /gcloudex
👉 Using ports and volumes

## Run hello app on docker

### interactive
```
docker run -it --rm -p 8080:8080 gcr.io/google-samples/hello-app:1.0
docker inspect admiring_poincare
docker exec -it admiring_poincare  sh
```

### detached
```
docker run -d -p 8080:8080 gcr.io/google-samples/hello-app:1.0
watch docker logs lucid_matsumoto
docker stop lucid_matsumoto
docker rm lucid_matsumoto
```

## run hello app on gke with as a pod
```
kubectl run --tty hello-app-nordine --image=gcr.io/google-samples/hello-app:1.0
kubectl get pod -o wide


kubectl run -i --rm --tty papline-nordine --image=alpine -- sh
  apk add curl
  curl clusterIP:8080
kubectl kill pod hello-app-nordine
```

## run hello app on gke with a deployment and notice the names of the pods
```
kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0
kubectl get deployment hello-server
kubectl describe deployment hello-server
```

## use kubectl proxy
```
docker run -it --rm -p 8080:8080 -v gcloudbekkops:/root/.config/gcloud google/cloud-sdk
kubectl port-forward --address 0.0.0.0 -n default prod/hello-app-nordine 8080:8080
```
👉 Check http://localhost:8080/ on your local browser

## create a service using Google load balancers
```
kubectl expose service hello-server --name hello-server-svc-internet-facing --type LoadBalancer --port 80 --target-port 8080
```
👉 Check kubectl get svc
👉 Check portal
👉 Access the application through the public IP

## create an internal load balancer
kubectl apply -f ilb.yaml



