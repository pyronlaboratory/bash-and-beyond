# No Hands, Just Playbooks

This project demonstrates basic configuration management using Ansible by provisioning and configuring a Linux server with modular roles.
Project: [https://roadmap.sh/projects/configuration-management](https://roadmap.sh/projects/configuration-management)

## Overview

The playbook configures and automates an Amazon Linux 2023 EC2 instance (or any RHEL-family Linux) with nginx, fail2ban, SSH key management, and a static app deployment.

- Base system configuration (packages, updates, fail2ban)
- SSH key configuration
- Nginx installation and service setup
- Deployment of a static website
  
---

## Project Structure

```
ansible-setup/
├── ansible.cfg              # Ansible settings
├── inventory.ini            # Your server(s)
├── setup.yml                # Main playbook
├── group_vars/
│   └── all.yml              # Shared variables
└── roles/
    ├── base/                # Updates, utilities, fail2ban, firewall hardening
    ├── ssh/                 # Adds a public key to authorized_keys
    ├── nginx/               # Installs + configures nginx
    └── app/                 # Deploys static site (tarball or git)
```

---

## Prerequisites

```bash
brew install ansible
```
or using pip,
```
pip install ansible
```

## Inventory

Edit `inventory.ini` and replace the host with your server’s public IP address or DNS name. Update the SSH user and private key path based on your environment:

```
[webservers]
<your-server-ip-or-domain>

[webservers:vars]
ansible_user=<your-username>
ansible_ssh_private_key_file=<path/to/your-private-key.pem>
```

## Adding an SSH Key

This project expects a public key at:

```bash
roles/ssh/files/id_rsa.pub
```

If you only have a private key (such as a `.pem` file), you can derive the corresponding public key:

```bash
ssh-keygen -y -f /path/to/your-private-key.pem > roles/ssh/files/id_rsa.pub
```

Ensure correct permissions:

```bash
chmod 600 /path/to/your-key.pem
```

## Running the Playbook
```
# Run all roles
ansible-playbook setup.yml

# Run a specific role by tag
ansible-playbook setup.yml --tags "base"
ansible-playbook setup.yml --tags "ssh"
ansible-playbook setup.yml --tags "nginx"
ansible-playbook setup.yml --tags "app"

# Combine tags
ansible-playbook setup.yml --tags "base,nginx"

# Dry run (check mode)
ansible-playbook setup.yml --check
```

## Deploying the App

### Option 1 — Tarball (local tarball deployment)

Place your `site.tar.gz` in `roles/app/files/` then run:

```bash
ansible-playbook setup.yml --tags "app"
```

A sample `site.tar.gz` is included in this repository for convenience.  
The contents are based on: [TheAviator2](https://github.com/Badestrand/TheAviator2)


### Option 2 — Git repo (git-based deployment)

```bash
ansible-playbook setup.yml --tags "app" \
  --extra-vars "app_repo_url=https://github.com/you/your-static-site"
```

## Key Variables (group_vars/all.yml)


| Variable | Default | Description | 
| -------- | ------- | ----------- |
| `app_tarball_src` | `files/site.tar.gz` | Local tarball path |
| `app_deploy_dir` | `/usr/share/nginx/html` | Server deploy path | 
| `app_repo_url` | `""` | Git repo URL (enables git deploy) | 
| `nginx_server_name` | `_` | Nginx `server_name` (your domain) | 
| `fail2ban_maxretry` | `5` | Failed attempts before ban | 
| `fail2ban_bantime` | `3600` | Ban duration in seconds |
| `fail2ban_findtime` | `600` | Time window for retries |
