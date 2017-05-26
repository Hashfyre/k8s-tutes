# Kubernetes Tutorials

A Set of graded Kubernetes tutorials to document self-progress and help peers

### Credits
  - Borrowed unabashedly from [janakiramm/kubernetes-101](https://github.com/janakiramm/kubernetes-101/tree/master/Docker)
    - Not forked as I intend to create a step by step guide for myself and others in a single repo
  - [github/rmenn](https://github.com/rmenn) for the mentorship

### Build a Docker image
Replace `DOCKER_HUB_USER` with your Docker Hub username.

```
cd Docker
docker build -t <DOCKER_HUB_USER>/web .
docker push <DOCKER_HUB_USER>/web
```

### Launch the app with Docker Compose
```
docker-compose up -d
```

### Test the app
```
curl localhost:5000
```

### Setup Minikube
[macOS / OS X: Minikube](minikube.md)

### 101: Pods exposed as Services
```
cd ../101-pod-service
kubectl create -f db-pod.yml
kubectl create -f db-svc.yml
kubectl create -f web-pod.yml
kubectl create -f web-svc.yml
```

### 102: Pods with ReplicaSet exposed as Services
WIP

### 103: Deployments exposed as Services
```
cd ../103-deployment-replicas-service
kubectl create -f db-dpl.yml
kubectl create -f db-svc.yml
kubectl create -f web-dpl.yml
kubectl create -f web-svc.yml
```

### Check that the Pods and Services are created
```
kubectl get pods
kubectl get svc
```

### Get the NodePort for the web Service. Make a note of the port.
```
kubectl describe svc web
```

### Test the app by using minkube service url

```
minikube service web --url
```
