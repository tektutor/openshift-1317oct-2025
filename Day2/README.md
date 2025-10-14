# Day 2

## Info - Container Orchestration Platform Overview
<pre>
- Automated application deployment and management
  - eliminates manual container lifecycle management
- Scalability
  - scale up/down when the user-traffic to your application increases or comes down
- Rolling Update
  - you can upgrade your live application from one version to other without any down-time
  - rollback to older stable version, in case the newly rollout version is unstable
- High Availability 
  - it has in-built monitoring features to check the health of your application
  - it has in-built monitoring features to check the readiness/live of your application
  - it can self-heal or repair your application
- load-balancing
  - you could run multiple instance of your application to speed-up the process
- service discovery
  - applications can be restricted for internal consumption only or can be exposed to external world via services
  - applications can be accessed using service name, which automatically gets resolved to respective IP address
- Resource optimization
  - In-built scheduler, which maintains the load of every server in the cluster and ensures the each server run ideal number of application workloads to avoid overloading a single server
- Security
  - you can secure your applications
  - you could use network policies to restrict application to application interaction
  - use TLS(https) 
- Logging
  - ELK
- CI/CD
- examples
  - Docker SWARM
  - Google Kubernetes
  - Red Hat Openshift
</pre>

## Info - Docker SWARM
<pre>
- Docker SWARM is developed as an opensource project by Docker Inc organization
- Docker's native Container Orchestration Platform
- it works a cluster
  - a group of servers forms the cluster
  - the server could be a physical machine, virtual machine or an ec2 instance or could be a container
- it is lightweight, hence with ease we can install this cluster in our laptop/desktop/workstations
- easy to learn and maintain
- but it is not production grade
- it is ideal for learning Container Orchestration Platform features
- also good for dev/qa environment for testing
- supports only Docker containerized application workloads, no other container runtimes or engines supported
</pre>

## Info - Kubernetes
<pre>
- Google developed this container orchestration platform
- it is opensource and production grade
- in order to deploy an application, you should a container image
- developed in go language
- works as a cluster of many nodes
- supports many differnet types of container runtimes and container engines
- any container runtime that implements the Container Runtime Interface (CRI) are supported by Kubernetes
- you could any linux OS in master and worker nodes
- each node is a server
- the server can an ec2 instance, could be virtual machine in your data-center, could be a physical server, etc
- the server can be installed with any Linux distribution
- it is opensource and time-tested
- before Google made this project as opensource, it was initially named borg and used withing google for many years
- there are two of nodes
  1. Master node
  2. Worker Node
- Master Node
  - Control Plane components components will be running here
    1. API Server (Pod)
    2. etcd database (Pod)
    3. Controller Managers (Pod)
    4. Scheduler (Pod)
  - Control Plane components runs only in master node
- you could install any Linux OS in master and worker nodes
- Control Plane components are the one which supports the container orchestration features
- Worker Node
  - this is where user application will be deployed and running
- it supports only command-line
- Kubernetes provides basic building blocks to support
  - Custom Resource Definintion[CRD]( New type of resources )
  - Custom Controller
- Operator SDK 
  - this can be used to develop operators that can be deployed into Kubernetes/Openshift to extend K8s API(features)
</pre>

## Info - Red Hat Openshift
<pre>
- Openshift is Red Hat's Kubernetes distribution  
- it is developed on top of Google Kubernetes
- Openshift is superset of Kubernetes, hence it supports all the Kubernetes features + addition openshift features
- it is enterprise product that requires license, hence one can expect world-wide support from Red Hat(an IBM company)
- Openshift supports many additional features on top of Kubernetes
  - Webconsole
  - User management
  - S2I ( Source to Image )
    - application can be deployed from GitHub/any version control source code
  - supports inbuilt internal container registry
  - supports Route, DeploymentConfig, Project new features etc.,
  - pre-integrated performance monitoring tools like Prometheus & Graphana
- Openshift is Kubernetes + Batteries included
- Openshift Master Nodes
  - OS Supported - the only OS supported is Red Hat Enterprise Linux Core OS (RHCOS)
- Openshift Worker Nodes
  - OS Supported
    - Red Hat Enterprise Linux ( RHEL ) or
    - Red Hat Enterprise Linux Core OS ( RHCOS ) - This is recommended by Red Hat
</pre>

## Info - Pod Overview
<pre>
- logical group of related containers is called Pod
- each Pod has a secret infra-container that supports networking
- technically, a Pod have can any number of containers, however as per best prace one container per Pod is recommended. The infra container is not counted, it is mandatory and managed by Kubernetes/Openshift internally.
- Unlike Docker, where every container was getting an IP assigned, in case of Pod - all the containers that are part of same Pod shares the IP address and Port range (0-65535)
- every Pod should reprent just application
</pre>

## Info - CRI-O Container Runtime
<pre>
- this is the only container runtime supported in Openshift
- applications running within Openshift must be root-less ( should run as non-admin user )
- any regular application that attempts to run as root(admin) are not allowed to run in Openshift
</pre>

## Info - Kubernetes namespace
<pre>
- For each team, ideally applications has to be deployed in a separate namespace
- in case, you haven't created a separate namespace to deploy your application, then it goes to default namespace
- default namespace, generally has un-restricted access, which is not recommended
- ideally we have create a separate namespace and deploy all the applications under that namespace for every project team
</pre>  

## Info - Openshift Project
<pre>
- is based on Kubernetes namespace
- it supports applying security policies, Role Based Access Control on a project level
- this way it is possible to control who has access to which projects
- only the team members of a project team, can be given access to applications inside a project
- this is a feature introduced in Openshift and not supported in Kubernetes
</pre>  

## Info - Red Hat Openshift High-Level Architecture
![openshift](openshiftArchitecture.png)
![openshift](master-node.png)

## Lab - Creating a Pod in plain Docker
First create a pause container
<pre>
docker run -d --name nginx-pause --hostname nginx registry.k8s.io/pause:latest
docker inspect nginx-pause | grep IPA
</pre>

Let's create a nginx web server container and connect it with nginx-pause container's network
```
docker run -d --name nginx --network=container:nginx-pause nginx:latest
docker ps
docker exec -it nginx /bin/sh
hostname
hostname -i
exit
```

## Info - Checking your openshift environments
```
kubectl version
oc version
oc get nodes
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/a229ea25-d1bc-48a6-9d7d-9e4282777d5b" />

## Lab - Listing Openshift Nodes in the cluster
```
oc get nodes
oc get nodes -o wide
```

## Lab - Finding more details about openshift nodes
```
oc get nodes
oc describe node/master01.ocp4.palmeto.org
oc describe node/master02.ocp4.palmeto.org
oc describe node/master03.ocp4.palmeto.org

oc describe node/worker01.ocp4.palmeto.org
oc describe node/worker02.ocp4.palmeto.org
oc describe node/worker03.ocp4.palmeto.org
```

## Lab - Listing projects in openshift cluster
```
oc get projects # Plural form
oc get project  # Singular form

oc get namespaces # Plural form
oc get namespace  # Singular form
oc get ns  # Short form
```

<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/344d9c55-15ad-47da-9029-46fdee9cc2ff" />

## Lab - Finding the current active project
```
oc project
```

## Lab - Switching between projects
```
oc project default
oc project openshift
```

## Lab - Listing the container images in openshift's internal registry
```
oc project openshift
oc get imagestreams
oc get imagestream
oc get is
```

## Lab - Create a project to deploy your applications under it
In the below command, replace 'jegan' with your name.  The newly created project becomes active project automatically.
```
oc new-project jegan
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/0498bbb2-1836-4605-a8e1-5cce8ef95f19" />

## Lab - Deploying your first application into openshift using imperative command
Make sure you replace 'jegan' with your name/project
```
oc project jegan
oc create deploy nginx --image=image-registry.openshift-image-registry.svc:5000/openshift/nginx:1.0 --replicas=3
```
<img width="60%" height="60%" alt="image" src="https://github.com/user-attachments/assets/d415e9ee-13b3-4de3-bdc4-49c128d220c0" />



List the deployments in your project namespace
```
oc get deployments
oc get deployment
oc get deploy
```

List the replicasets in your project namespace
```
oc get replicasets
oc get replicaset
oc get rs
```

List the pods in your project namespace
```
oc get pods
oc get pod
oc get po
```

List multiple resources 
```
oc get deploy,rs,po
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/eb321c93-0151-42ac-9a80-a0f64c8fe480" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/2a78f584-ebee-438b-9452-4879974b7b23" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/4349f706-1a05-4409-9d4b-afa7b192ae0a" />

## Lab - Finding more details about deployment
```
oc describe deploy/nginx
```

## Lab - Finding more details about replicaset
```
oc describe rs/nginx-7b58f48fbb
```

## Lab - Finding more details about a pod
```
oc describe pod/nginx-7b58f48fbb-dnmf2
```

## Lab - Edit a pod definition
```
oc edit pod/nginx-7b58f48fbb-tfq25
```

## Lab - Edit a replicaset definition
```
oc edit rs/nginx-7b58f48fbb
```

## Lab - Edit a deployment definition
```
oc edit deploy/nginx
```

## Lab - Finding the IP address of Pods
```
oc get pods -o wide
```
<img width="75%" height="75%" alt="image" src="https://github.com/user-attachments/assets/61289e30-f5b3-488a-b633-5f2e4e08b1e5" />

## Lab - Getting inside a Pod shell
```
oc rsh deploy/nginx
oc exec -it nginx-7b58f48fbb-qghbw -- /bin/sh
```

## Lab - Scale up nginx deployment
```
oc get pods -o wide
oc scale deploy/nginx --replicas=5
oc get pods -o wide

```

## Lab - Scale down nginx deployment
```
oc get pods -o wide
oc scale deploy/nginx --replicas=3
oc get pods -o wide
```
