#!/usr/bin/env bash
docker build -t jasonrayles/multi-client:latest -t jasonrayles/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jasonrayles/multi-server:latest -t jasonrayles/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jasonrayles/multi-worker:latest -t jasonrayles/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jasonrayles/multi-client:latest
docker push jasonrayles/multi-server:latest
docker push jasonrayles/multi-worker:latest
docker push jasonrayles/multi-client:$SHA
docker push jasonrayles/multi-server:$SHA
docker push jasonrayles/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jasonrayles/multi-server:$SHA
kubectl set image deployments/client-deployment client=jasonrayles/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jasonrayles/multi-worker:$SHA