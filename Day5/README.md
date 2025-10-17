# Day 5

## Demo - Install Red Hat AMQ Broker Operator
```
mkdir -p openshift-jms-setup/{operators,broker,queues,application}
cd openshift-jms-setup
```

Install AMQ Broker Operator - operators/amq-operator-subscription.yaml
<pre>
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: amq-broker-rhel8
  namespace: openshift-operators
spec:
  channel: 7.11.x
  name: amq-broker-rhel8
  source: redhat-operators
  sourceNamespace: openshift-marketplace  
</pre>

Create AMQ Broker Instance broker/amq-broker-instance.yaml
<pre>
apiVersion: broker.amq.io/v1beta1
kind: ActiveMQArtemis
metadata:
  name: amq-broker
  namespace: jms-demo
spec:
  deploymentPlan:
    size: 1
    image: registry.redhat.io/amq7/amq-broker-rhel8:7.11
    requireLogin: false
    persistenceEnabled: true
  console:
    expose: true
  acceptors:
    - name: amqp
      protocols: amqp
      port: 5672
    - name: core
      protocols: core
      port: 61616  
</pre>

Create Queues - queues/order-queue.yaml
<pre>
apiVersion: broker.amq.io/v1beta1
kind: ActiveMQArtemisAddress
metadata:
  name: order-queue
  namespace: jms-demo
spec:
  addressName: order.queue
  queueName: order.queue
  routingType: anycast  
</pre>

Create Topics - queues/notification-topic.yaml
<pre>
apiVersion: broker.amq.io/v1beta1
kind: ActiveMQArtemisAddress
metadata:
  name: notification-topic
  namespace: jms-demo
spec:
  addressName: notification.topic
  queueName: notification.topic
  routingType: multicast  
</pre>

Create Application Configuration - application/configmap.yaml
<pre>
apiVersion: v1
kind: ConfigMap
metadata:
  name: jms-app-config
  namespace: jms-demo
data:
  application.yml: |
    spring:
      activemq:
        broker-url: tcp://amq-broker-hdls-svc:61616
        user: admin
        password: admin
      jms:
        pub-sub-domain: false
    logging:
      level:
        com.example.jms: DEBUG  
</pre>

## Lab - Deploying your JMS Producer
```
oc new-project jegan
oc create deploy jms-producer --image=tektutor/jms-producer:1.0
oc create deploy jms-consumer --image=tektutor/jms-consumer:1.0

oc get pods
oc logs -f your-jms-producer-pod-name
oc logs -f your-jms-consumer-pod-name
```

## Info - Microservice Overview
<pre>
- Microservice is an architectural style where application is built as a collection of small, 
  independent and loosely coupled services
- each microservice will be responsible for specific business logic
- microservice to microservice communications can be achieved with HTTP/REST, gRPC or message queues
- Key properties of Microservices
  - Single Responsibility
  - Can be deployed independently
  - Technology agnostic - can be developed using any language stack
  - Decentralized Database
  - Resilience - Failures in one service will not affect others or will not bring down the entire application
  - Scalability - every microservice can be scaled up/down independent of other microservices 
</pre>

## Info - Monolithic Application Overview
<pre>
- is a traditional application that is built as a single application binary
- all components will be bundled in the single application binary
  - Frontend
  - Business Layer
  - Data Access Layer
- Key properties of Monolithic applications
  - Single codebase
  - Tighly coupled components
  - Entire application is deployed as a single unit
  - Centralized Database
  - Scaling Limitations
</pre>

## Info - Secure your Openshift Cluster and applications deployed in Openshift

#### Authentication & Authorization
<pre>
- Authentication
  - Could setup Identity providers (IDPs) to authenticate openshift login
  - LDAP, GitHub, GitLab, Google, HTPasswd, Keycloak (OIDC)
- ServiceAccounts vs User accounts
- Token and OAuth flows (oc whoami -t)

- Authorization
  - RBAC (Role-Based Access Control)
  - Roles, ClusterRoles, RoleBindings, ClusterRoleBindings
  - Custom Roles vs. default roles (admin, view, edit, etc.)
  - Least privilege principle
</pre>

#### Network Security
<pre>  
- Pod-to-Pod & Pod-to-Service
- NetworkPolicy (namespaced) and ClusterNetworkPolicy (cluster-wide)
- Default deny-all and zero-trust networking
- Controlling ingress/egress with egress firewall rules
- Ingress Security
- Routes and TLS termination types 
- Securing routes with certificates 
</pre>

#### Cluster Security & Hardening
<pre>  
- Security Context Constraints (SCC) – OpenShift equivalent of PodSecurityPolicies
- restricted, anyuid, privileged SCCs
- Creating custom SCCs
- Admission Controllers and Validating/Mutating Webhooks
- Pod Security Standards (Baseline, Restricted)
- Running containers as non-root
- Disabling privileged escalation
</pre>

#### Image & Supply Chain Security
<pre>  
- ImageStreams and trusted registries
- image signature verification (oc adm policy add-scc-to-user, oc adm signature)
- Image scanning (e.g., Red Hat Quay, Clair, Trivy)
- Content Trust and ImagePolicy admission
- Immutable images and reproducible builds
- Security scanning in CI/CD pipelines
</pre>

#### Secrets & Config Security
<pre>  
- Kubernetes Secrets vs ConfigMaps
- Encryption at rest with KMS providers (e.g., AWS KMS, Vault)
- Sealed Secrets (Bitnami SealedSecrets)
- External secret managers (HashiCorp Vault, CyberArk, AWS Secrets Manager)
- Securing environment variables in deployments
</pre>

#### Platform Access & API Security
<pre>  
- API server authentication and RBAC for oc and kubectl users
- OpenShift Console access restrictions
- API audit logging
- Certificate management for API server and etcd
- OAuth token lifetimes and rotation
</pre>

#### Compliance & Monitoring
<pre>  
- Compliance Operator (CIS Benchmark for OpenShift)
- OpenSCAP scans and remediation
- Audit logging and forwarding (e.g., to ELK or SIEM)
- Security events in oc get events and cluster logs
- Cluster-wide alerts for security breaches
</pre>

#### Security Tools & Operators
<pre>  
- Compliance Operator – CIS, NIST profiles
- Gatekeeper / OPA – policy as code
- ACS (Red Hat Advanced Cluster Security) – runtime threat detection, network graph
- Falco – behavioral threat detection
- Trivy – image scanning in CI/CD
</pre>

#### Secure Multitenancy
<pre>  
- Namespace isolation best practices
- Project quotas and limits
- Network segmentation per tenant
- RBAC delegation to team leads
- Resource constraints to prevent noisy neighbor issues
</pre>

#### Security Updates & Patch Management
<pre>  
- OpenShift upgrade process & channels (fast, stable)
- Node OS updates (RHCOS)
- Operator lifecycle management (OLM) security
- CVE tracking and remediation using Red Hat Insights
</pre>

#### Runtime & Workload Security
<pre>  
- Pod security context:
  - runAsUser, fsGroup, readOnlyRootFilesystem
- Dropping Linux capabilities
  - Seccomp profiles and AppArmor (on supported platforms)
- Container resource limits to prevent DoS
- Detecting crypto-mining and lateral movement
</pre>

#### Ingress/Egress & Perimeter Security
<pre>  
- Securing ingress with TLS, WAF integration (e.g., F5, HAProxy)
- Rate limiting & DoS protection
- Egress control with EgressFirewall and proxies
- Bastion hosts & jump boxes for controlled access
</pre>

#### Backup & Disaster Recovery (Security Angle)
<pre>  
- etcd encryption and backup security
- Secrets encryption during backups
- Immutable backup storage
- RBAC restrictions for restore operations
</pre>

#### Zero Trust Architecture
<pre>  
- Network segmentation
- Identity-aware access to workloads
- Mutual TLS between services
- Policy enforcement using OPA/Gatekeeper
- Just-in-time access control
</pre>

#### Best Practices & Standards
<pre>  
- CIS Benchmark for OpenShift
- NIST 800-53 alignment
- ISO 27001 security practices
- Regular pen-testing and red teaming
- Shift-left security in CI/CD
</pre>


## Lab - Setting up CICD Jenkins Job

Download Jenkins
```
cd ~
wget https://get.jenkins.io/war-stable/2.528.1/jenkins.war
```

Starting jenkins in interactively from a terminal ( once you start jenkins, you may open new terminal tabs as the current terminal tab will be used by Jenkins forever)
```
cd ~
java -jar ./jenkins.war
```


## Certifications Recommended
<pre>
- Red Hat Openshift I - Containers & Kubernetes ( DO180 )
- Red Hat Openshift Development II - Containerizing Applications ( DO288 )
- Red Hat Openshift Application Developer Exam ( EX288 )
- Red Hat Certified Specialist in Openshift Application Development
- Red Hat Certified Specialist in Containers 
- Red Hat Certified Architect (RHCA)
</pre>
