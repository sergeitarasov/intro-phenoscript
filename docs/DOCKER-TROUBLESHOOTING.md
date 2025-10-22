# Docker Troubleshooting Guide

## 🔧 Common Docker Issues and Solutions

This guide helps resolve the most common problems students encounter when using Docker for the PhenoScript course.

## 🚨 Installation Issues

### Docker Desktop Won't Start

**Windows:**
```
Error: "Docker Desktop requires Windows 10 Pro/Enterprise/Education"
Solution: Enable WSL 2 or upgrade Windows
```
1. Enable WSL 2: `wsl --install`
2. Restart computer
3. Try Docker Desktop again

**Mac:**
```
Error: "Docker.app is damaged and can't be opened"
Solution: Security settings issue
```
1. Go to System Preferences → Security & Privacy
2. Click "Allow" for Docker
3. Or run: `sudo xattr -rd com.apple.quarantine /Applications/Docker.app`

**Linux:**
```
Error: "docker: command not found"
Solution: Docker not installed or not in PATH
```
```bash
# Check if Docker is installed
which docker

# If not installed, follow installation guide for your distro
# If installed but not found, add to PATH:
export PATH=/usr/bin:$PATH
```

### Permission Issues

**"Permission denied" when running Docker**

**Linux:**
```bash
# Add yourself to docker group
sudo usermod -aG docker $USER

# Log out and back in, then test
docker run hello-world
```

**Windows/Mac:**
```
Make sure Docker Desktop is running as administrator
```

## 🐋 Docker Runtime Issues

### Docker Command Not Found

**Check if Docker is running:**
- **Windows**: Look for whale icon in system tray
- **Mac**: Look for whale icon in menu bar  
- **Linux**: Run `sudo systemctl status docker`

**Restart Docker:**
- **Windows/Mac**: Quit and restart Docker Desktop
- **Linux**: `sudo systemctl restart docker`

### Container Won't Start

**Error: "Cannot connect to the Docker daemon"**
```bash
# Check Docker status
docker info

# If error, restart Docker service
# Linux:
sudo systemctl restart docker

# Windows/Mac: Restart Docker Desktop
```

**Error: "Port already in use"**
```bash
# Find and stop conflicting containers
docker ps
docker stop [container_id]
```

## 📁 Volume Mounting Issues

### "No such file or directory" Errors

**Windows (Command Prompt):**
```cmd
# Use %cd% for current directory
docker run --rm -v %cd%/phenotypes:/app/phenotypes ...

# NOT: $(pwd) - that's for Mac/Linux
```

**Windows (PowerShell):**
```powershell
# Use ${PWD} for current directory
docker run --rm -v ${PWD}/phenotypes:/app/phenotypes ...
```

**Mac/Linux:**
```bash
# Use $(pwd) for current directory
docker run --rm -v $(pwd)/phenotypes:/app/phenotypes ...

# Make sure you're in the right directory
pwd
ls phenotypes/
```

### File Permission Problems

**Linux - Output files owned by root:**
```bash
# Fix ownership after running Docker
sudo chown -R $(whoami):$(whoami) student-output/

# Or run Docker with your user ID
docker run --rm -u $(id -u):$(id -g) -v $(pwd)/phenotypes:/app/phenotypes ...
```

## 📝 PhenoScript-Specific Issues

### Syntax Errors in PhenoScript

**"Parsing failed" or "Invalid syntax"**

Check for these common mistakes:

**Missing commas:**
```phenoscript
// ❌ Wrong:
head(
    shape(round)
    color(black)  // Missing comma above
)

// ✅ Correct:
head(
    shape(round),
    color(black)
)
```

**Wrong brackets:**
```phenoscript
// ❌ Wrong:
head[shape(round)]

// ✅ Correct:
head(shape(round))
```

**Mismatched parentheses:**
```phenoscript
// ❌ Wrong:
head(
    antenna = [
        COUNT(2)
    )
}

// ✅ Correct:
head(
    antenna = {
        COUNT(2)
    }
)
```

### "File not found" in Container

**Check file paths:**
```bash
# Make sure files exist
ls phenotypes/descriptions.phs

# Check file permissions
ls -la phenotypes/
```

**Windows path issues:**
```cmd
# Use forward slashes in Docker commands
docker run -v %cd%/phenotypes:/app/phenotypes ...

# NOT backslashes:
docker run -v %cd%\phenotypes:/app/phenotypes ...
```

## 🌐 Network and Download Issues

### Docker Image Won't Download

**"Pull access denied" or "Repository not found"**
```bash
# Check Docker Hub status
docker pull hello-world

# Try with explicit registry
docker pull docker.io/sergeit215/phenoscript-nl-converter:latest
```

**Slow download speeds:**
```bash
# Check available space
df -h  # Linux/Mac
dir   # Windows

# Clear Docker cache if needed
docker system prune
```

### Firewall/Network Issues

**Corporate networks or restricted internet:**
```bash
# Configure Docker to use proxy
# Add to ~/.docker/config.json:
{
  "proxies": {
    "default": {
      "httpProxy": "http://proxy.company.com:8080",
      "httpsProxy": "http://proxy.company.com:8080"
    }
  }
}
```

## 🖥️ Platform-Specific Issues

### Windows Specific

**WSL 2 backend errors:**
```cmd
# Update WSL 2
wsl --update

# Set WSL 2 as default
wsl --set-default-version 2
```

**Hyper-V conflicts:**
```
Disable VirtualBox or VMware if running
Enable Hyper-V in Windows Features
```

### Mac Specific

**Apple Silicon (M1/M2/M3) compatibility:**
```bash
# Force x86 emulation if needed
docker run --platform linux/amd64 --rm -v $(pwd)/phenotypes:/app/phenotypes ...
```

**"Rosetta 2 required" error:**
```bash
# Install Rosetta 2
softwareupdate --install-rosetta
```

### Linux Specific

**SELinux issues (CentOS/RHEL):**
```bash
# Temporarily disable SELinux
sudo setenforce 0

# Or add SELinux context
sudo chcon -Rt svirt_sandbox_file_t /path/to/project/
```

**AppArmor issues (Ubuntu):**
```bash
# Check AppArmor status
sudo aa-status

# Reload Docker profile if needed
sudo apparmor_parser -r /var/lib/snapd/apparmor/profiles/snap.docker.docker
```

## 🔍 Debugging Commands

### Check Docker Status
```bash
# Basic Docker info
docker --version
docker info

# List running containers
docker ps

# List all containers
docker ps -a

# Check Docker logs
docker logs [container_name]
```

### Test Docker Installation
```bash
# Run hello-world test
docker run hello-world

# Run simple test with volume
docker run --rm -v $(pwd):/test alpine ls /test
```

### Check System Resources
```bash
# Linux/Mac:
df -h          # Disk space
free -h        # Memory
top            # CPU usage

# Windows:
dir            # Directory listing
systeminfo     # System information
```

## 🆘 Getting Help

### Before Asking for Help

1. **Try the solution** from this troubleshooting guide
2. **Check Docker Desktop** is running and updated
3. **Verify file paths** and permissions
4. **Test with hello-world** container first
5. **Copy exact error messages**

### Where to Get Help

1. **Course instructor** - for assignment-specific issues
2. **Docker documentation** - https://docs.docker.com/
3. **Docker community forums** - https://forums.docker.com/
4. **GitHub issues** - for problems with the course materials
5. **Stack Overflow** - tag questions with `docker` and `phenoscript`

### Information to Include When Asking for Help

- **Operating System** (Windows 10, macOS Big Sur, Ubuntu 20.04, etc.)
- **Docker version** (`docker --version`)
- **Exact command** you ran
- **Complete error message** (copy and paste)
- **File structure** (output of `ls` or `dir`)
- **What you expected** to happen

## ✅ Quick Fix Checklist

When something doesn't work, try these in order:

- [ ] Restart Docker Desktop
- [ ] Check you're in the correct directory
- [ ] Verify file paths use correct slashes
- [ ] Ensure Docker has file permissions
- [ ] Test with hello-world container
- [ ] Check available disk space
- [ ] Update Docker Desktop
- [ ] Restart your computer
- [ ] Try running as administrator
- [ ] Disable antivirus temporarily

---

**Remember**: Most Docker issues are related to file paths, permissions, or Docker not running properly. Start with these basics before diving into complex solutions!