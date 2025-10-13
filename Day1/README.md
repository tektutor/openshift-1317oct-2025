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

