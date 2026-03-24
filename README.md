# ship-it-static
Lightweight static site deployment using Nginx and rsync.

Project: https://roadmap.sh/projects/static-site-server

## Overview

This project demonstrates how to provision a remote Linux server, configure Nginx to serve a static website, and deploy updates using `rsync`.

---

## Requirements

- Remote Linux server (AWS EC2 / DigitalOcean / any provider)
- SSH access to the server
- Nginx installed and configured
- Static website (HTML, CSS, assets)
- Rsync for deployment

---

## Amazon EC2 Server Setup

### 1. Launch Instance
- Create an EC2 instance (Amazon Linux 2023 recommended)
- Download `.pem` key file
- Allow inbound rules:
  - SSH (22)
  - HTTP (80)

### 2. Connect via SSH
```bash
ssh -i <private-keypair.pem> <username>@<server-ip>
```

---

## Install and Configure Nginx

### 1. Install Nginx
```bash
sudo dnf update -y
sudo dnf install -y nginx
```
### 2. Start and Enable Service
```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```
### 3. Verify Installation
```bash
sudo systemctl status nginx
```

---

## Rsync Deployment

### Deploy Script (`deploy.sh`)

```bash
#!/bin/bash

rsync -avz -e "ssh -i <private-keypair.pem>" /path/to/local/static.zip <username>@<server-ip>:~
```

### Configuration

Replace the placeholders below with your own values:

- `<private-keypair.pem>`: Path to your SSH private key
- `/path/to/local/static.zip`: Path to your local static site archive
- `<username>`: Remote server user (e.g., ec2-user)
- `<server-ip>`: Public IP address or domain of your server

### Usage

Make script executable:
```bash
chmod +x deploy.sh
```

Run deployment:
```bash
./deploy.sh
```

---

## Configure Static Site

### 1. Extract Files on Server
```bash
mkdir source
unzip static.zip -d source/
```

### 2. Move Files to Web Directory
```bash
sudo rm -rf /usr/share/nginx/html/*
sudo cp -r source/* /usr/share/nginx/html/
```

### 3. Restart Nginx
```bash
sudo systemctl restart nginx
```

### 4. Access Website
```bash
http://your-server-ip
```
