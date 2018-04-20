#!/bin/bash

CONSUL_INTERNAL_IP=$(kubectl get svc consul-internal-load-balancer -o jsonpath='{.spec.clusterIP}')
NOMAD_EXTERNAL_IP=$(kubectl get svc nomad -o jsonpath='{.spec.clusterIP}')
VAULT_EXTERNAL_IP=$(kubectl get svc vault -o jsonpath='{.spec.clusterIP}')
cfssl gencert -initca ca/ca-csr.json | cfssljson -bare ca


cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca/ca-config.json \
  -hostname="consul,consul.${NAMESPACE}.svc.cluster.local,localhost,server.dc1.consul,127.0.0.1,${CONSUL_INTERNAL_IP}" \
  -profile=default \
  ca/consul-csr.json | cfssljson -bare consul

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca/ca-config.json \
  -hostname="vault,vault.${NAMESPACE}.svc.cluster.local,localhost,vault.dc1.consul,vault.service.consul,127.0.0.1,${VAULT_EXTERNAL_IP}" \
  -profile=default \
  ca/vault-csr.json | cfssljson -bare vault

cat vault.pem ca.pem > vault-combined.pem

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca/ca-config.json \
  -hostname="localhost,client.global.nomad,nomad,nomad.${NAMESPACE}.svc.cluster.local,global.nomad,server.global.nomad,127.0.0.1,${NOMAD_EXTERNAL_IP}" \
  -profile=default \
  ca/nomad-csr.json | cfssljson -bare nomad

GOSSIP_ENCRYPTION_KEY=$(consul keygen)
echo $GOSSIP_ENCRYPTION_KEY > ~/.gossip_encryption_key

kubectl create secret generic consul \
  --from-literal="gossip-encryption-key=${GOSSIP_ENCRYPTION_KEY}" \
  --from-file=ca.pem \
  --from-file=consul.pem \
  --from-file=consul-key.pem

  kubectl create secret generic vault \
  --from-file=ca.pem \
  --from-file=vault.pem=vault-combined.pem \
  --from-file=vault-key.pem

  kubectl create secret generic nomad \
  --from-file=ca.pem \
  --from-file=nomad.pem \
  --from-file=nomad-key.pem
