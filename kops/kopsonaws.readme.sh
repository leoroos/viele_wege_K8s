# Script file to play along
# Mostly taken from
# https://kubernetes.io/docs/setup/custom-cloud/kops/

aws route53 create-hosted-zone --name k8s.lroos.de --caller-reference 1

aws s3 mb s3://clusters.k8s.lroos.de

export KOPS_STATE_STORE=s3://clusters.k8s.lroos.de
export NAME=ittage.k8s.lroos.de
export ZONES="eu-central-1a,eu-central-1b,eu-central-1c"

kops create cluster --zones $ZONES $NAME --state $KOPS_STATE_STORE
# --master-zones $ZONES

kops edit cluster --name $NAME

kops update cluster --name $NAME --yes

# list cluster configurations
kops get cluster

# edit general cluster settings
kops edit cluster $NAME

# details wie docker.logOpt
# etcdClusters.backupStore

# instancgroup editing,
kops get ig

# edit instance group nodes
kops edit ig --name $NAME nodes

kops rolling-update cluster --name $NAME 

# edit instance group masters
kops edit ig --name $NAME master-eu-central-1a


kops update cluster $NAME --yes

kops edit ig nodes
kops update cluster --yes
kops rolling-update cluster


# Example app

# login
$(aws ecr get-login --no-include-email --region eu-central-1)

../example_app/build.sh ecr

kubectl apply -f .

# Need to create AWSServiceRoleForElasticLoadBalancing
# Can easily be done through Create Role and choosing the according service


aws route53 change-resource-record-sets --hosted-zone-id Z66UJ4OFMC85T --change-batch file://extras/create-resource-record-sets.json

# Dashboard setup (in ns kube-system)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/kubernetes-dashboard/v1.1.0.yaml
kubectl create serviceaccount dashboard
kubectl create clusterrolebinding dashboard-admin \
	--clusterrole=cluster-admin \
	--serviceaccount=kube-system:dashboard

# SSH Access
ssh -i ~/.ssh/id_rsa admin@api.tstkops.k8s.lroos.de
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa admin@api.tstkops.k8s.lroos.de


kops delete cluster $NAME --yes
