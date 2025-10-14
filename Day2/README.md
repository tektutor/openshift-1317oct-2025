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
