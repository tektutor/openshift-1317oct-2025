# Day 1

## Lab - Cloning this repository in your training machine ( terminal )
```
cd ~
git clone https://github.com/tektutor/openshift-1317oct-2025.git
```

## Info - Hypervisor Overview
<pre>
- Hypervisor is generic term for virtualization technology
- with the help of virtualization, we can run multiple OS on a single physical machine
- multiple OS can actively run side by side
- there are 2 types of Hypervisors
  1. Type 1 - a.k.a bare metal hypervisor ( they don't need Host OS )
  2. Type 2 - a.k.a hosted hypervisor
- examples
  - Type 1
    - Microsoft Hyper-V
    - KVM
    - VMWare vSphere
  - Type 2
    - VMWare Workstation ( Windows & Linux )
    - Parallels ( Mac OS-X )
    - Oracle VirtualBox ( Windows, Mac & Linux )
- for each VM, dedicated hardware resources must be allocated
  - CPU Core
  - RAM
  - Storage ( HDD/SDD )
  - virtual Network Cards
  - virtual Graphics cards
- hence this type of virtualization is referred as heavy-weight virtualization
- the Guest OS that runs within the VMs, they are fully-functional Operating System, functionally they are same as OS running on top of a physical server
- each VM represents one Operating System
</pre>

## Info - Type 1 Hypervisor
<pre>
- Virtual Machines can be created directly on top of the Hardware with no Host OS 
- hence, you can save on the Host OS license cost
- the hardware resources can be utilized by the Guest OS running on the Virtual Machines (VM)
- this type of Hypervisors are used in Workstations & Servers
</pre>

## Info - Type 2 Hypervisor
<pre>
- In order to install Type 2 Hypervisor, we must have installed some Host OS ( Windows, Linux or Mac OS-X )
- Hypervisor software is installed on top of the Host OS
- VMs are created on top of the Hypervisor
- this type of Hypervisors are used in Laptops, Desktops & Workstations
</pre>

## Processor
<pre>
- Processors comes in 2 packages
  1. SCM ( Single Chip Module - One IC has one Processor )
  2. MCM ( Multiple Chip Module - One IS has multiple Processors )
- Server Motherboards they generally supports multiple Processor Sockets ( 8 Sockets )
  - Let's assume, in each Processor Socket if we install a MCM Processor with 4 Processor/IC ( 1 Socket )
  - Let's assume, each Processor supports about 256 CPU Cores
  - Total number of Physical Cores - 8 x 4 x 256 = 32*256 = 8192 Physical CPU core
  - What are the total logic/virtual cores = 8192 * 2 = 16384 logical/virtual cores
</pre>

## Info - Hypervisor High-Level Architecture
<img width="2632" height="1603" alt="image" src="https://github.com/user-attachments/assets/16bda6b2-396e-4636-80e4-aa85607d0c11" />

## Info - Containerization
<pre>
- is an application virtualization technology
- each containers represents anapplicaiton process or one application
- in certain case, one or more containers represents a single application
- containers are not Operating System
- containers are not allocated with dedicated hardware resources
  - all containers that runs in the same Host machine, shares the hardware resources available on the Host machine
  - containers don't have their own OS Kernel, hence they depend on the Host OS Kernel
- each container get its own
  - IP address(es)
  - Network Stack
  - Network Card
  - File System
  - Port range ( 0 - 65535 )
- hence containers behave like a VM/OS in many scenarios, however container is just application process not a OS
- technically comparing a container with VM/OS is wrong
- generally people tend to compare containers with VM/OS as there are many similarities, but they are still technically different
- containers will never be able to replace virtualization or Operating System
- containers and virtualization are not competing technology, they are complementing technology
- containers can run on OS installed on bare metal, VMs, etc.,
</pre>

## Info - Container Runtime Overview
<pre>
- is a low-level software, not user-friendly that helps us manage containers and container images
- as it is not user-friendly, generally end-users don't use this software directly
- internally they depend on the Linux Kernel to support containerization
- examples
  - runC container runtime
  - cRun container runtime
  - CRI-O container runtime
</pre>

## Info - Container Engine Overview
<pre>
- is a high-level software, very user-friendly that helps us manage containers and container images
- internally, they depend on Container Runtime to manage containers and container images
- examples
  - Docker - Container Engine
    - depends on containerd, which internally depends on runC container runtime
  - Podman - Container Engine
    - depends on either cRun/CRI-O container runtime
</pre>

## Info - Docker High-Level Architecture
![docker](DockerHighLevelArchitecture.png)

## Info - Docker Image Layers
![docker](DockerLayers.png)

## Lab - Checking the docker version and details
```
docker --version
docker info
docker images
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/44d9e34d-2587-43e2-8b6d-ded46c229b2f" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/7bf9b0a7-1438-4576-aa13-15a40ab6aac2" />


## Lab - Listing image from docker local registry
```
docker images
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/675e090e-e1f1-4be6-aaa5-04ef199292c0" />


## Lab - Downloading a docker image from Docker Remote Registry ( Docker Hub website ) to local docker registry
```
docker pull hello-world:latest
docker images
```

## Lab - Creating a container and running in background(daemon) mode
In the below command, replace 'jegan' with your name to avoid name conflicts.
```
docker run -dit --name ubuntu1-jegan --hostname ubuntu1-jegan ubuntu:latest /bin/bash
docker run -dit --name ubuntu2-jegan --hostname ubuntu2-jegan ubuntu:latest /bin/bash
```
Note
<pre>
- dit - stands for deattached/daemon/background interactive
- name - name of the container
- hostname - hostname of the container
- ubuntu:latest - name of docker image and its tag(version)
- /bin/bash - we are launching a terminal as the default application inside the container
</pre>

List all running containers
```
docker ps
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/82d55917-bb77-4c7b-9b08-dbb5968ce375" />
 
## Lab - Getting inside a container shell
```
docker ps | grep jegan
docker exec -it ubuntu1-jegan /bin/bash
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/c1ec1c18-012e-480b-a044-f9941556d94b" />

## Lab - Stopping running containers

Stop a single running container
```
docker ps
docker stop ubuntu1-jegan
docker ps
docker ps -a
```

Create two more additional containers
```
docker run -dit --name ubuntu3-jegan --hostname ubuntu3-jegan ubuntu:latest /bin/bash
docker run -dit --name ubuntu4-jegan --hostname ubuntu4-jegan ubuntu:latest /bin/bash
docker ps 
```

Stop multiple running containers
```
docker stop ubuntu2-jegan ubuntu3-jegan ubuntu4-jegan
docker ps
docker ps -a
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/0cb760eb-93c1-401f-94b8-cc950ae3046d" />

## Lab - Starting exited(stopped) containers

Start a single exited container
```
docker ps -a
docker start ubuntu1-jegan
docker ps
```

Starting multiple exited containers
```
docker start ubuntu2-jegan ubuntu3-jegan ubuntu4-jegan
docker ps
```

<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/e22b72de-aa0d-4c5f-85c1-22ae6630f7ad" />

## Lab - Listing containers whose name matches a pattern
```
docker ps
docker ps --filter "name=jegan"
```

<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/8a4f9548-c093-4abb-b62c-e00a89b160eb" />

## Lab - Stopping containers that matches a name pattern
```
docker ps
docker ps --filter "name=jegan"
docker ps -q --filter "name=jegan"
docker stop $(docker ps -q --filter "name=jegan")

docker ps
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/954e44f5-e3f9-40ae-88a3-cbdcdde300b3" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/038ec96c-8adb-4476-a821-c7c158ebb874" />

## Lab - Stopping containers that matches multiple name patterns
```
docker ps --filter "name=jegan|bennet"
docker stop $(docker ps -q --filter "name=jegan|bennet")
docker ps
```

## Lab - Starting containers that matches multiple name patterns
```
docker ps --filter "name=jegan|bennet"
docker start $(docker ps -aq --filter "name=jegan|bennet")
docker ps
```

## Lab - Restarting containers that matches multiple name patterns
```
docker ps --filter "name=jegan|bennet"
docker restart $(docker ps -aq --filter "name=jegan|bennet")
docker ps
```

## Lab - Renaming a container
```
docker rename <your-current-container-name> <new-container-name>
```

## Lab - Deleting running containers

In order to gracefully delete a container, it must be stopped first
```
docker stop ubuntu1-jegan
docker rm ubuntu1-jegan
```

If you wish to delete a container forcibly
```
docker rm -f ubuntu2-jegan
```

To delete multiple running containers forcibly
```
docker rm -f ubuntu1-jegan ubuntu2-jegan ubuntu3-jegan ubuntu4-jegan
docker rm -f $(docker ps -q --format "name=jegan")
```

## Lab - Deleting a docker image from your local docker registry
```
docker images
docker rmi hello-world:latest
docker images
```

## Lab - Finding IP address of a container
```
docker inspect container9_jegan | grep IPA
docker inspect -f {{.NetworkSettings.IPAddress}} container9_jegan
docker inspect -f {{.NetworkSettings.IPAddress}} container32_jegan
docker inspect -f {{.NetworkSettings.IPAddress}} container19_jegan
docker inspect -f {{.NetworkSettings.IPAddress}} container29_jegan
ping -c 2 172.17.0.7
```  
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/3e02f569-b9ce-453d-8313-64eadf15e986" />

## Lab - Inspecting a container to get details about the container
```
docker inspect ubuntu1-jegan
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/215bd517-a187-4ea5-89df-d438c373acfe" />

## Lab - Inspecting an image
```
docker image inspect ubuntu:latest
```

<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/dcf4052b-097b-4cea-bb76-01bc872f0e71" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/0b27874f-8662-4c72-b2b4-715af2a51edf" />

## Lab - Creating a container in interactive(foreground) mode

When you exit from the container shell, it will also exit the container.
```
docker run -it --name ubuntu10-jegan ubuntu:latest /bin/bash
hostname
hostname -i
ls
exit
docker ps -a
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/ae59da07-6d29-417a-a6c2-ecc65a2f0e2d" />

## Info - What kind of applications are ideal to be containerized?
<pre>
- any blocking applications
- Database servers, Web Servers, Application Servers
- REST API, SOAP API, Microservices
- Shell commands
</pre>

## Lab - Let's create a nginx web server container
```
docker run -d --name nginx1-jegan --hostname nginx1-jegan nginx:latest
docker run -d --name nginx2-jegan --hostname nginx2-jegan nginx:latest
docker run -d --name nginx3-jegan --hostname nginx3-jegan nginx:latest
docker ps
```

Find the IP Addresses of the web server containers
```
docker inspect nginx1-jegan | grep IPA
docker inpsect -f {{.NetworkSettings.IPAddress}} nginx1-jegan
docker inpsect -f {{.NetworkSettings.IPAddress}} nginx2-jegan
docker inpsect -f {{.NetworkSettings.IPAddress}} nginx3-jegan
curl http://172.17.0.2:80
curl http://172.17.0.3:80
curl http://172.17.0.4:80
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/8868366e-c365-4b06-88f5-5303a03788d9" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/5ce5a89d-b27e-423f-b62c-425a1f93750f" />


## Info - Docker Port Forwarding
![docker](PortForwarding.png)

## Lab - Setting up Load Balancer using nginx docker image

Let's first create 3 web server containers. You need to name your containers as nginx1-jegan replacing 'jegan' with your name to avoid naming conflicts.
```
docker run -d --name nginx1 --hostname nginx1 nginx:latest
docker run -d --name nginx2 --hostname nginx2 nginx:latest
docker run -d --name nginx3 --hostname nginx3 nginx:latest
```

Let's check the container IPs
```
docker inspect nginx1 | grep IPA
docker inspect nginx2 | grep IPA
docker inspect nginx3 | grep IPA
```

Let's customize the web pages on each web server
```
echo "Server 1" > index.html
docker cp index.html nginx1:/usr/share/nginx/html/index.html

echo "Server 2" > index.html
docker cp index.html nginx2:/usr/share/nginx/html/index.html

echo "Server 3" > index.html
docker cp index.html nginx3:/usr/share/nginx/html/index.html
```

Let's verify the web pages served by nginx1, nginx2 and nginx3 web server containers
```
curl http://172.17.0.2:80
curl http://172.17.0.3:80
curl http://172.17.0.4:80
```

<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/9c787006-f377-4512-9c63-4584e799112b" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/fa3f9b7e-eee6-4fbf-a388-1b9949462563" />

Let's create a lb container with port-forwarding ( You need to choose your non-conflicting port in the place of 8001 )
```
docker run -d --name lb --hostname lb -p 8001:80 nginx:latest
docker ps
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/cabb370c-aa94-4897-ba5f-801540e376d7" />

Let's configure the lb container to work as a load balancer. For this we need to configure the nginx.conf with the respective nginx1, nginx2 and nginx3 web server container IPs as shown below
<pre>
# Nginx for OpenShift – fully compatible with non-root UID
# user directive removed (ignored anyway in OpenShift)

worker_processes auto;

error_log /dev/stderr warn;
pid /var/run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    upstream backend {
        server 172.17.0.2:80;
        server 172.17.0.3:80;
        server 172.17.0.4:80;
    }

    server {
        location / {
            proxy_pass http://backend;
        }
    }
}  
</pre>

Let's copy the configured nginx.conf into the lb container
```
docker cp nginx.conf lb:/etc/nginx/nginx.conf
```

To apply config changes done on lb container, we need to restart lb container
```
docker restart lb
docker ps
```

<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/d45f9e77-2ee2-47c2-ba33-b001290c7e27" />

From your terminal, each time you should see responses coming from different web server.
```
curl  -L --http2 http://localhost:8001
curl  -L --http2 http://localhost:8001
curl  -L --http2 http://localhost:8001
```

Accessing the lb from your lab machine firefox browser
```
http://localhost:8001
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/a3ee6f7d-d0e0-4389-a73d-e1b81e959d45" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/9cb77404-0f50-4e02-9fe2-d96e89714f18" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/a48e5129-9d45-45bf-9a96-eca7db200930" />

In order to check the web server and lb logs
```
docker logs nginx1
docker logs lb
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/fd14b684-fd4c-41ef-841d-6d63e1d9ea5c" />

<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/e8051fe3-7ef4-4f6c-b9c6-e1ea7bb869f0" />


## Lab - Docker Volume Mounting(Mapping) to store data outside the container
```
cd ~
mkdir -p /tmp/jegan/mysql

docker run -d --name mysql --hostname mysql -e MYSQL_ROOT_PASSWORD=root@123 -v /tmp/jegan/mysql:/var/lib/mysql mysql:latest

docker ps
```

Let's get inside the mysql container shell, when it prompts for password type 'root@123' without quotes
```
docker exec -it mysql /bin/sh
mysql -u root -p
SHOW DATABASES;
CREATE DATABASE tektutor;
USE tektutor;

CREATE TABLE training ( id INT NOT NULL, name VARCHAR(300) NOT NULL, duration VARCHAR(300) NOT NULL, PRIMARY KEY(id));

INSERT INTO training VALUES ( 1, "DevOps", "5 Days" );
INSERT INTO training VALUES ( 2, "Advanced Openshift", "5 Days" );

SELECT * FROM training;

exit
exit
```

Let's delete the mysql container
```
docker rm -f mysql
```

Let's create new mysql container using the same external folder and mount it inside new container
```
docker run -d --name mysql2 --hostname mysql2 -e MYSQL_ROOT_PASSWORD=root@123 -v /tmp/jegan/mysql:/var/lib/mysql mysql:latest

docker exec -it mysql2 /bin/sh
mysql -u root -p
SHOW DATBASES;
USE tektutor;
SHOW TABLES;
SELECT * FROM training;
exit
exit

ls -l /tmp/jegan/mysql
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/6bdf961f-7cc7-4692-ba3d-8d94c52291a0" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/8c392516-e482-4712-b9e2-8fa36148e054" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/94c4be0f-a96c-41bf-812f-2f921f88f067" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/33973ecb-a4d9-454f-b65c-1121800f8a0b" />

<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/2e395442-c0b3-4d34-816e-cf625a6d39c6" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/1b0df838-bbe8-4029-80ac-60c8a3dd134a" />
## Lab - Building a custom docker image
```
cd ~
git clone https://github.com/tektutor/spring-ms.git
cd spring-ms
tree
docker build -t tektutor/hello-microservice:1.0 .
docker images | grep hello-micro
docker run -d --name hello --hostname hello tektutor/hello-microservice:1.0
docker ps
docker inspect hello | grep IPA
curl http://172.17.0.3:8080
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/c4f5c88d-7884-42a0-8408-3af847f99607" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/9176b5fe-3e5d-4445-a3d2-4ca9b3914469" />

## Lab - Containerize a dot net application
```
cd ~
mkdir MyDotNetApp
cd MyDotNetApp
dotnet new webapi -n MyApi
cd MyApi
```

Run and test your application location
```
dotnet run
```

From another terminal tab
```
curl http://localhost:5030/weatherforecast
```

Inside the MyApi folder, create a Dockerfile with the below content
<pre>
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8080
ENTRYPOINT ["dotnet", "MyApi.dll"]  
</pre>

Build your custom image
```
docker build tektutor/my-dotnet-app .
docker images | grep my-dot
```

Run the container
```
docker run -d --name mydotapp --hostname mydotapp tektutor/my-dotnet-app
```

Find the IP address of your container
```
docker inspect mydotapp | grep IPA
curl http://172.17.0.4:8080//weatherforecast
```
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/0c1c954d-a03c-4aae-89fa-7b9c7f576d19" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/8eb579a2-9838-4ae9-beb9-617024bc59cb" />
<img width="1920" height="1168" alt="image" src="https://github.com/user-attachments/assets/6773f1d6-9727-407c-b32d-09ed7b87822a" />
