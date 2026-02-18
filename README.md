
****<img width="1904" height="984" alt="image" src="https://github.com/user-attachments/assets/6c40bbfc-f66f-407d-9f46-201767b05300" />




<img width="1641" height="1307" alt="image" src="https://github.com/user-attachments/assets/348fd287-8f87-455d-a22d-0fbc6c51a840" />


# Home‑Cloud (Concise Guide)

A personal homelab platform that turns a few machines into a small self‑hosted cloud.
Goal: learn real infrastructure by *building and operating it yourself* (not by using a public cloud).

The system provisions servers, deploys applications, monitors services, and exposes them over HTTPS inside a private network. It can be rebuilt from code at any time.

---

## What It Provides

* Reproducible machines (infrastructure as code)
* One‑command application deployment (git‑based)
* Internal DNS service discovery
* HTTPS routing to services
* Monitoring, dashboards, and alerts
* Centralized automation

Instead of configuring computers manually, the environment is defined and recreated automatically.

---

## Node Roles

| Node    | Purpose                       |
| ------- | ----------------------------- |
| gateway | reverse proxy + HTTPS routing |
| control | automation + orchestration    |
| worker  | runs applications and jobs    |
| monitor | metrics, dashboards, alerts   |

Multiple roles may initially run on a single machine.

---

## Core Components

* **Automation:** Ansible playbooks
* **Routing:** reverse proxy (HTTPS)
* **Service discovery:** internal DNS
* **Deployment:** git‑based deploys
* **Monitoring:** metrics + dashboards + alerts

---

## What You Can Do

* Bring a fresh machine online automatically
* Deploy a service from a git repo
* Restart crashed services
* Access apps via `https://service.home`
* Monitor CPU, memory, uptime
* Receive alerts when something breaks

---

## Monitoring / UI Services

**Host & Metrics**

* Netdata — real‑time metrics and kernel activity visualization
* Prometheus — metric collection/storage
* Grafana — dashboards and historical graphs

**Management**

* Cockpit — Linux system web control panel (services, logs, networking, terminal)
* Portainer — container management UI
* Netdata Cloud — centralized metrics dashboard across hosts

These tools together create a single‑pane operational view of the lab.

---

## Libvirt Integration — MiniCloud Control Plane

Instead of manually running `qemu-system-*`, a runner program talks to **libvirt** (which controls QEMU/KVM).

You are effectively building a small EC2‑like control plane.

### Layer Model

```
Runner → libvirt → QEMU/KVM → Virtual Machines
Control Plane   Manager   Hypervisor   Instances
```

| Layer    | Cloud Equivalent   |
| -------- | ------------------ |
| Runner   | EC2 control plane  |
| libvirt  | hypervisor manager |
| QEMU/KVM | hypervisor         |
| VM       | instance           |

---

## What Libvirt Provides

* Persistent VM lifecycle (define/start/stop/destroy)
* Managed networking (NAT bridge + DHCP)
* Storage pools and volumes
* Automatic IP assignment (easier SSH)
* Reduced QEMU complexity
* Stable orchestration behavior

Your runner becomes a **machine orchestrator** instead of a simple process launcher.

---

## Runner Development Levels

**Level 1 – Shell Runner (start here)**

* Wrap `virsh`, `virt-install`, `virt-clone`
* Fast and educational

**Level 2 – API Runner**

* Use libvirt API (Python or Go)
* Structured automation

**Level 3 – Hybrid**

* API lifecycle + CLI utilities (e.g., cloud‑init ISO generation)

Recommended progression:

1. Prototype in shell
2. Automate in Python/Go
3. Replace CLI calls with API

---

## Minimal Provisioning Workflow

1. Ensure storage pool exists
2. Create VM disk from base image
3. Generate cloud‑init seed ISO
4. Define VM (`virt-install --import`)
5. Start VM
6. Obtain IP from DHCP
7. Print SSH command

This equals basic EC2 instance provisioning.

---

## Key Commands

### Create Volume

```bash
sudo virsh vol-create-as default worker1.qcow2 20G --format qcow2
```

### Upload Base Image (optional)

```bash
sudo virsh vol-upload --pool default worker1.qcow2 ./images/ubuntu-base.qcow2
```

### Cloud‑Init Seed

```bash
cloud-localds seed-worker1.iso user-data meta-data
```

### Import VM (ARM example)

```bash
sudo virt-install \
  --name worker1 \
  --memory 2048 \
  --vcpus 2 \
  --arch aarch64 \
  --machine virt \
  --import \
  --disk path=/var/lib/libvirt/images/worker1.qcow2,format=qcow2,bus=virtio \
  --disk path=./seed-worker1.iso,device=cdrom \
  --network network=default,model=virtio \
  --osinfo ubuntu22.04 \
  --noautoconsole
```

### Lifecycle

```bash
sudo virsh start worker1
sudo virsh shutdown worker1
sudo virsh destroy worker1
```

### Get VM IP

```bash
sudo virsh net-dhcp-leases default
```

Then:

```
ssh ubuntu@<ip>
```

---

## Why This Matters

Building this teaches real cloud mechanics:

* disk images
* machine identity
* network assignment
* boot orchestration
* instance lifecycle
* reliability and observability

This mirrors AWS EC2, Proxmox, and private cloud platforms.

---

## Core Learning Goals

* Linux system administration
* networking
* distributed systems
* observability
* reliability engineering
* deployment automation

The homelab becomes a safe environment to experiment, break systems, and rebuild them.

---

## Conceptual Takeaway

A server is not a device.

> A server is a disposable process created from an image and attached to a network.

