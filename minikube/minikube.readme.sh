# vim :set ft=sh:
# https://kubernetes.io/docs/tutorials/hello-minikube/
#
brew install minikube

# configure DNS. In my case it seemed that the hyperkit did not reroute queries to port 53 to my Mac's DNS server.
# Maybe a permission problem on newer macs maybe the configurations differ. A simple fix it to adjust it manually
minikube ssh
# also very nice for debugging
# first remove symlink so that it no longer gets overwritten, than add what you need
sudo vi /etc/resolv.conf
# e.g. adjust for your machines dns resolver or google's 8.8.8.8


# Kubectl config
kubectl config get-contexts
kubectl config set-context --current=true --cluster=minikube --namespace=kube-system

minikube start
minikube status

minikube get node
minikube get pod


# Exmaple App
eval $(minikube docker-env)
docker build ...

kubectl apply -f .
kubectl get pods -o jsonpath='{.items[*].metadata.name}'

minikube service helloworld

minikube stop
minikube delete
