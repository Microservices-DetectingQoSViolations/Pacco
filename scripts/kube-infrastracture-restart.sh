#!/bin/bash

cd ../kube/helm/infrastructure

echo ========================================================
echo Restarting: mongo
echo ========================================================

kubectl delete -f mongo-secret.yml
kubectl apply -f mongo-secret.yml

microk8s.helm3 uninstall mongo
microk8s.helm3 install mongo -f mongo-bitnami-config.yml bitnami/mongodb

for SERVICE in "jaeger-tracing jaegertracing/jaeger jaeger-config.yml" "prometheus stable/prometheus prometheus-config.yml" "rabbitmq stable/rabbitmq-ha rabbitmq-ha-config.yml" "redis bitnami/redis redis-config.yml"
do
	 set -- $SERVICE
	 echo ========================================================
	 echo Restarting: $1
	 echo ========================================================

	 microk8s.helm3 uninstall $1
	 microk8s.helm3 install $1 -f $3 $2

	 echo ========================================================
done
$SHELL
