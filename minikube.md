#### Instructions on spinning up a local cluster

##### OSX

- Download [Docker for Mac] ( https://docs.docker.com/docker-for-mac/ )
- Install [minikube] ( https://github.com/kubernetes/minikube/releases )
- Install xhyve driver `brew install docker-machine-driver-xhyve`
- docker-machine-driver-xhyve need root owner and uid
 - `sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve`
 - `sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve`
- Set minikube to use xhyve `minikube config set vm-driver xhyve`
- Install kubectl - `brew install kubectl`
- Start minikube `minikube start`
- Set kubectl to use minikube `kubectl config use-context minikube`
- Confirm its working `kubectl get services --all-namespaces`
- Share Docker Daemon with minikube `eval $(minikube docker-env)`

ref:  [xhyve-driver docs](https://github.com/kubernetes/minikube/blob/master/docs/drivers.md#xhyve-driver)
