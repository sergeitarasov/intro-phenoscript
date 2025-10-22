# Windows Setup Guide for PhenoScript Course

## 🪟 Setting Up PhenoScript on Windows

This guide will help you set up everything needed for the PhenoScript course on Windows.

## Step 1: Install Git (if not already installed)

### Option A: Install Git for Windows
1. Go to https://git-scm.com/download/win
2. Download the latest version
3. Run the installer with default settings
4. Open **Git Bash** or **Command Prompt**

### Option B: Use GitHub Desktop (Easier for beginners)
1. Go to https://desktop.github.com/
2. Download and install GitHub Desktop
3. Sign in with your GitHub account

## Step 2: Download the Course Repository

### Using Git Bash or Command Prompt:
```bash
# Navigate to your desired folder (e.g., Desktop)
cd Desktop

# Clone the repository
git clone https://github.com/sergeitarasov/intro-phenoscript.git

# Enter the project folder
cd intro-phenoscript
```

### Using GitHub Desktop:
1. Click **Clone a repository from the Internet**
2. Enter: `sergeitarasov/intro-phenoscript`
3. Choose where to save it (e.g., Desktop)
4. Click **Clone**

## Step 3: Install Docker Desktop

### Download Docker Desktop
1. Go to https://www.docker.com/products/docker-desktop/
2. Click **Download for Windows**
3. Run the installer (`Docker Desktop Installer.exe`)

### Installation Steps
1. **Enable WSL 2** when prompted (recommended)
2. **Restart your computer** when installation completes
3. **Start Docker Desktop** from Start menu
4. **Sign up/Sign in** to Docker Hub (free account)
5. Wait for Docker to start (whale icon in system tray)

### Verify Installation
Open **Command Prompt** or **PowerShell** and run:
```cmd
docker --version
```
You should see something like: `Docker version 24.0.x`

## Step 4: Test the PhenoScript Pipeline

### Navigate to Project Folder
```cmd
# Open Command Prompt and navigate to your project
cd Desktop\intro-phenoscript
```

### Run the Docker Container
```cmd
# Create output folder
mkdir output

# Run the PhenoScript pipeline
docker run --rm -v %cd%/phenotypes:/app/phenotypes -v %cd%/output:/app/docker-output sergeit215/phenoscript-nl-converter:latest
```

### Check Results
```cmd
# Open the output folder
explorer output\output-NL
```

You should see HTML files with natural language descriptions!

## Step 5: Edit Your Species Description

### Open the Description File
1. Navigate to `phenotypes\descriptions.phs`
2. Open with any text editor (Notepad, Notepad++, VS Code)
3. Edit the species description
4. Save the file

### Run Again with Your Changes
```cmd
# Run the pipeline again
docker run --rm -v %cd%/phenotypes:/app/phenotypes -v %cd%/output:/app/docker-output sergeit215/phenoscript-nl-converter:latest

# View your new results
explorer output\output-NL
```

## 🚨 Troubleshooting

### Docker Issues

**"Docker command not found"**
- Make sure Docker Desktop is running (check system tray)
- Restart Command Prompt after installing Docker

**"Access denied" or permission errors**
- Run Command Prompt as Administrator
- Make sure Docker Desktop is running

**WSL 2 installation required**
- Follow the prompts to install WSL 2
- Restart computer after installation

### File Path Issues

**"No such file or directory"**
- Make sure you're in the correct folder: `cd Desktop\intro-phenoscript`
- Use `dir` to list files and verify you're in the right place

**Volume mounting issues**
- Use `%cd%` in Command Prompt for current directory
- Use `$PWD` in PowerShell for current directory

### Windows-Specific Tips

1. **Use Command Prompt or PowerShell** (not Git Bash) for Docker commands
2. **File paths use backslashes** (`\`) on Windows
3. **Run as Administrator** if you encounter permission issues
4. **Antivirus software** might interfere - add Docker to exceptions

## 📁 Folder Structure After Setup

```
Desktop\intro-phenoscript\
├── phenotypes\
│   ├── descriptions.phs          ← Edit this file!
│   ├── example-Scarabaeus.phs
│   └── phs-config.yaml
├── output\                       ← Your results appear here
│   ├── output-NL\               ← HTML descriptions
│   └── output\                  ← OWL files
├── docs\                        ← Course documentation
└── README.md                    ← Course overview
```

## ✅ Success Checklist

- [ ] Git installed and working
- [ ] Repository downloaded to your computer
- [ ] Docker Desktop installed and running
- [ ] Docker command works in terminal
- [ ] Successfully ran the PhenoScript pipeline
- [ ] Can see HTML output files
- [ ] Can edit and re-run with your own descriptions

## 🆘 Need More Help?

- **Docker Desktop Documentation**: https://docs.docker.com/desktop/windows/
- **Git for Windows Guide**: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
- **Course Issues**: Create an issue on GitHub or ask your instructor

---

**Next Steps**: Once everything is working, check out [Writing Species Descriptions](WRITING-DESCRIPTIONS.md) to learn PhenoScript syntax!