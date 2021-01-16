#!/bin/bash

cd ../kube/helm/infrastructure

echo ========================================================
echo Restarting: mongo
echo ========================================================

kubectl delete -f mongo-secret.yml
kubectl apply -f mongo-secret.yml

helm uninstall mongo
helm install mongo -f mongo-bitnami-config.yml bitnami/mongodb

for SERVICE in "redis bitnami/redis redis-config.yml"
do
	 set -- $SERVICE
	 echo ========================================================
	 echo Restarting: $1
	 echo ========================================================

	 helm uninstall $1
	 helm install $1 -f $3 $2

	 echo ========================================================
done
$SHELL
