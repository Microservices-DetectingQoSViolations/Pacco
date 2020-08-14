#!/bin/bash
SERVICES=(api-gateway availability customers deliveries identity operations order-maker orders parcels pricing vehicles)

cd ../kube/services

for SERVICE in ${SERVICES[*]}
do
	 echo ========================================================
	 echo Restarting: $SERVICE
	 echo ========================================================
	 cd $SERVICE
	 
	 kubectl delete -f config-map.yml -f deploy.yml -f service.yml
	 
	 cd ..
done