kubectl expose service hello-server --name hello-server-svc-lb-pip --type LoadBalancer --port 80 --target-port 8080
watch kubectl get svc
## Check the new LB in Google Cloud Portal
kubectl delete service hello-server-svc-lb-pip
