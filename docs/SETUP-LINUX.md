# Linux Setup Guide for PhenoScript Course

## 🐧 Setting Up PhenoScript on Linux

This guide will help you set up everything needed for the PhenoScript course on Linux (Ubuntu, Debian, CentOS, etc.).

## Step 1: Install Git

### Ubuntu/Debian:
```bash
sudo apt update
sudo apt install git
```

### CentOS/RHEL/Fedora:
```bash
# CentOS/RHEL
sudo yum install git

# Fedora
sudo dnf install git
```

### Arch Linux:
```bash
sudo pacman -S git
```

## Step 2: Download the Course Repository

```bash
# Navigate to your home directory
cd ~

# Clone the repository
git clone https://github.com/sergeitarasov/intro-phenoscript.git

# Enter the project folder
cd intro-phenoscript
```

## Step 3: Install Docker

### Ubuntu/Debian:
```bash
# Update package index
sudo apt update

# Install dependencies
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io

# Add user to docker group (avoid sudo)
sudo usermod -aG docker $USER

# Log out and back in, then test
docker --version
```

### CentOS/RHEL:
```bash
# Install dependencies
sudo yum install -y yum-utils

# Add Docker repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker
sudo yum install docker-ce docker-ce-cli containerd.io

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group
sudo usermod -aG docker $USER

# Log out and back in, then test
docker --version
```

### Fedora:
```bash
# Install Docker
sudo dnf install docker

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group
sudo usermod -aG docker $USER

# Log out and back in, then test
docker --version
```

## Step 4: Test the PhenoScript Pipeline

```bash
# Navigate to project folder
cd ~/intro-phenoscript

# Create output folder
mkdir -p student-output

# Run the PhenoScript pipeline
docker run --rm \
  -v $(pwd)/phenotypes:/app/phenotypes \
  -v $(pwd)/student-output:/app/docker-output \
  sergeit215/phenoscript-nl-converter:latest

# Check results
ls student-output/output-NL/
```

## Step 5: Edit Your Species Description

```bash
# Open the file in your preferred editor
nano phenotypes/descriptions.phs        # Simple terminal editor
vim phenotypes/descriptions.phs         # Vim editor
gedit phenotypes/descriptions.phs       # GNOME text editor
kate phenotypes/descriptions.phs        # KDE text editor
code phenotypes/descriptions.phs        # VS Code (if installed)
```

## 🚨 Troubleshooting

### Docker Issues

**"Permission denied" when running Docker**
```bash
# Make sure you're in the docker group
groups $USER

# If 'docker' is not listed, add yourself and restart
sudo usermod -aG docker $USER
# Log out and back in

# Or run with sudo (not recommended)
sudo docker run --rm ...
```

**"Docker daemon not running"**
```bash
# Start Docker service
sudo systemctl start docker

# Enable Docker to start at boot
sudo systemctl enable docker

# Check status
sudo systemctl status docker
```

### Linux Distribution Specific

**SELinux issues (CentOS/RHEL)**
```bash
# If you get SELinux errors, temporarily disable
sudo setenforce 0

# Or configure SELinux for Docker
sudo setsebool -P container_manage_cgroup on
```

**Firewall issues**
```bash
# Ubuntu/Debian
sudo ufw allow 2376

# CentOS/RHEL
sudo firewall-cmd --permanent --add-port=2376/tcp
sudo firewall-cmd --reload
```

## ✅ Success Checklist

- [ ] Git installed and working
- [ ] Repository downloaded to your computer
- [ ] Docker installed and running
- [ ] User added to docker group
- [ ] Docker command works without sudo
- [ ] Successfully ran the PhenoScript pipeline
- [ ] Can see HTML output files
- [ ] Can edit and re-run with your own descriptions

---

**Next Steps**: Once everything is working, check out [Writing Species Descriptions](WRITING-DESCRIPTIONS.md) to learn PhenoScript syntax!