#!/bin/bash

# use minikube docker daemon
eval $(minikube docker-env)

# build docker images
docker build backend -t backend:latest
docker build frontend -t frontend:latest

# apply descriptors
kubectl apply -f k8s/frontend-ingress.yml
kubectl apply -f k8s/frontend-service.yml
kubectl apply -f k8s/frontend-deployment.yml
kubectl apply -f k8s/backend-service.yml
kubectl apply -f k8s/backend-deployment.yml

echo Done! Use command \"minikube tunnel\" to access application on localhost
