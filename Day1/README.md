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
