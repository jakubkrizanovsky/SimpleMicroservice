#!/bin/bash

kubectl delete -f k8s/frontend-ingress.yml
kubectl delete -f k8s/frontend-service.yml
kubectl delete -f k8s/frontend-deployment.yml
kubectl delete -f k8s/backend-service.yml
kubectl delete -f k8s/backend-deployment.yml
