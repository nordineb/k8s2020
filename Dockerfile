# Use the official image as a parent image.
FROM google/cloud-sdk:latest

ARG DEBIAN_FRONTEND=noninteractive

# put the dockerfile inside the image
COPY Dockerfile /Dockerfile

# update
RUN apt-get update

# install the necessary tools
RUN apt-get install -y apt-utils vim watch wget kubectx git  curl 
RUN cd /home \
	&& curl https://storage.googleapis.com/kubernetes-helm/helm-v2.14.1-linux-amd64.tar.gz -o helm.tar.gz \
	&& tar -xvf helm.tar.gz \
	&& rm helm.tar.gz \
	&& mv linux-amd64/helm /usr/local/bin/helm \
	&& chmod +x /usr/local/bin/helm \
	&& helm --help \
	&& cd

# expose 8080 so that we can use kubectl proxy command
EXPOSE 8080

