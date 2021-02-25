

# Use the official image as a parent image.
FROM google/cloud-sdk:latest

# put the dockerfile inside the image
COPY Dockerfile /Dockerfile

# update
RUN apt-get update

# install the necessary tools
RUN apt-get install -y apt-utils vim watch wget kubectx

# expose 8080 so that we can use kubectl proxy command
EXPOSE 8080

