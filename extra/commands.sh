
kubectl scale --replicas=3 deployment/helloworld
kubectl scale --current-replicas=2 --replicas=3 deployment/mysql
