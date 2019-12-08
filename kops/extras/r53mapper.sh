#!/bin/bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/route53-mapper/v1.3.0.yml

# In a service:
 
# metadata:
#   annotations:
#      domainName: "helloworld.k8s.lroos.de"
#      service.beta.kubernetes.io/aws-load-balancer-ssl-cert: |-
#         arn:aws:acm:eu-central-1:AWS_ACCOUNT_NUMBER:certificate/6ce986ba-1193-43ee-8d67-3df8c4e6149e
#      service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http
#      service.beta.kubernetes.io/aws-load-balancer-ssl-ports: "443"
