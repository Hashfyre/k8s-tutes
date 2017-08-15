#!/bin/bash

kubectl apply -f consul/consul-dns-svc.yml
kubectl apply -f consul/consul-lb-svc.yml
kubectl apply -f consul/consul-svc.yml
kubectl apply -f nomad/nomad-svc.yml
kubectl apply -f vault/vault-svc.yml

./init-secrets.sh

kubectl apply -f consul/consul-pv-claim.yml
kubectl apply -f consul/consul-sfset.yml