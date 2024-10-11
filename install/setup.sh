#!/bin/sh

pushd ..

# Deploy the Gateways

# Gloo Edge API
kubectl apply -f gateways/gateway-proxy.yaml
#K8S Gateway API
kubectl create namespace ingress-gw --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f gateways/gw.yaml

# Label the default namespace, so the gateway will accept the HTTPRoute from that namespace.
printf "\nLabel default namespace ...\n"
kubectl label namespaces default --overwrite shared-gateway-access="true"

# Deploy the World Cities Soap Service application
printf "\nDeploy World Cities Soap Service application ...\n"
kubectl apply -f apis/world-cities-soap-service-deployment.yaml
kubectl apply -f apis/world-cities-soap-service-service.yaml

# RouteOptions
printf "\nDeploy RouteOptions ...\n"
kubectl apply -f options/world-cities-routeoption.yaml

# HTTPRoute
printf "\nDeploy HTTPRoute ...\n"
kubectl apply -f routes/api-example-com-httproute.yaml

printf "\nWait for the RouteOption to be translated ...\n"
sleep 3

# VirtualServices
printf "\nDeploy VirtualServices ...\n"
kubectl apply -f virtualservices/api-example-com-vs.yaml

popd