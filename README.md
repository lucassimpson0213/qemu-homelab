
****<img width="1904" height="984" alt="image" src="https://github.com/user-attachments/assets/6c40bbfc-f66f-407d-9f46-201767b05300" />



<img width="1641" height="1307" alt="image" src="https://github.com/user-attachments/assets/348fd287-8f87-455d-a22d-0fbc6c51a840" />


# Home-Cloud

A personal homelab platform that turns a few machines into a small self-hosted cloud.

The goal of this project is to learn real infrastructure by building it — not by using a cloud provider, but by *becoming* one.

This system provisions servers, deploys applications, monitors services, and exposes them over HTTPS inside a private network.

---

## What this is

Home-Cloud is a mini platform-as-a-service running on a Raspberry Pi and virtual machines.

It provides:
- reproducible machines (infrastructure as code)
- one-command application deployment
- internal DNS service discovery
- HTTPS routing to services
- monitoring and alerts
- centralized automation

Instead of manually configuring computers, the entire environment is defined in code and can be rebuilt at any time.

---

## Architecture

Each node has a role:

| Node      | Purpose |
|----------|------|
| gateway  | reverse proxy + HTTPS routing |
| control  | automation + orchestration |
| worker   | runs applications and jobs |
| monitor  | metrics, dashboards, alerts |

Multiple roles may run on the same machine at the beginning.

---

## Core Components

- automation: Ansible playbooks
- routing: reverse proxy (HTTPS)
- service discovery: internal DNS
- monitoring: metrics + dashboards
- deployment: git-based application deploys

---

## What it can do

- bring a fresh machine online automatically
- deploy a service from a git repo
- restart crashed services
- expose apps at `https://service.home`
- monitor CPU, memory, and uptime
- send alerts when something breaks

---

## Why

Modern developers rely on cloud platforms but rarely understand how they actually work.

This project is an attempt to learn:

- Linux system administration
- networking
- distributed systems
- observability
- reliability engineering
- deployment automation

The homelab becomes a controlled environment for experimenting, breaking things, and rebuilding them safely.

---

## Example

After setup: