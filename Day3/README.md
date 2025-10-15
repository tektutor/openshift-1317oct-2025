# Day 3

## Lab - Deploying the application using S2I docker strategy
```
oc delete project jegan
oc new-project jegan

oc new-app --name=hello https://github.com/tektutor/spring-ms.git --strategy=docker
oc expose svc/hello

oc logs -f bc/hello
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/ec5f1fed-12f4-4e65-b36b-a522e563052c" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/3215ca29-c395-481a-a283-63c1ce78c402" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/f106bf48-5580-411b-af37-88fd93ec9a56" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/387dd5a5-062b-4af8-a83d-45b8441a9350" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/a811d3fd-8f72-422a-a97a-1bda255502d8" />

