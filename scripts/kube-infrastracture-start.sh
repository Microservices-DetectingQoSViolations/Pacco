#!/bin/bash

cd ../kube/helm/infrastructure

echo ========================================================
echo Restarting: mongo
echo ========================================================

kubectl apply -f mongo-secret.yml
helm install mongo -f mongo-bitnami-config.yml bitnami/mongodb

for SERVICE in "jaeger-tracing jaegertracing/jaeger jaeger-config.yml" "prometheus stable/prometheus prometheus-config.yml" "rabbitmq stable/rabbitmq-ha rabbitmq-ha-config.yml" "redis bitnami/redis redis-config.yml"
do
	 set -- $SERVICE
	 echo ========================================================
	 echo Restarting: $1
	 echo ========================================================

	 helm install $1 -f $3 $2

	 echo ========================================================
done
$SHELL
