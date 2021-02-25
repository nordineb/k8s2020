[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/nordineb/k8s2020/tree/master/into-kubernetes)

## Gitpod

Gitpod is a dev-environment-as-a-service and our workspace is configure with:
* gcloud SDK
* kubectlx/kubens
* other stuff that we need for the workshop
* All the vscode settings needed for the workshop (YAML settings etc...) 

[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/<your-org>/<your-project>)

## Connect to our GKE cluster 
👉 gcloud auth login
👉 gcloud config set project k8s2021
👉 gcloud container clusters get-credentials prod-cluster --zone europe-west3-a