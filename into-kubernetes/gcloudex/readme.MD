# Create a custom docker image based on gcloud SDK 

## Purpose
Add a couple of utilities and expose port 8080 for kubectl proxy

## Build the image
```
docker build . --tag gcloudex:latest
```

## Run the container with  volumes
```
docker run -it --rm -p 8080:8080 -v gcloudbekkops:/root/.config/gcloud gcloudex
```