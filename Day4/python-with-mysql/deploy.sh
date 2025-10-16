oc apply -f mysql-secret.yml
oc apply -f mysql-pv.yml
oc apply -f mysql-pvc.yml
oc apply -f mysql-deploy.yml
oc apply -f mysql-svc.yml

oc apply -f flask-deploy.yml
oc apply -f flask-app-svc.yml
oc apply -f flask-app-route.yml
