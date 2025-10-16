oc delete -f flask-app-route.yml
oc delete -f flask-app-svc.yml
oc delete -f flask-deploy.yml
oc delete -f mysql-svc.yml
oc delete -f mysql-deploy.yml
oc delete -f mysql-pvc.yml
oc delete -f mysql-pv.yml
oc delete -f mysql-secret.yml
