# Mac Setup Guide for PhenoScript Course

## 🍎 Setting Up PhenoScript on Mac

This guide will help you set up everything needed for the PhenoScript course on macOS.

## Step 1: Install Prerequisites

### Check if Git is Already Installed
Open **Terminal** (Applications → Utilities → Terminal) and type:
```bash
git --version
```

If you see a version number, Git is installed. If not, continue below.

### Install Git (if needed)

#### Option A: Install Xcode Command Line Tools (Recommended)
```bash
xcode-select --install
```
Click **Install** when prompted.

#### Option B: Install Git via Homebrew
```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Git
brew install git
```

#### Option C: Use GitHub Desktop (Easier for beginners)
1. Go to https://desktop.github.com/
2. Download GitHub Desktop for Mac
3. Install and sign in with your GitHub account

## Step 2: Download the Course Repository

### Using Terminal:
```bash
# Navigate to your Desktop
cd ~/Desktop

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
2. Click **Download for Mac**
3. Choose the right version:
   - **Apple Silicon** (M1, M2, M3 chips): Download "Apple Chip"
   - **Intel Mac**: Download "Intel Chip"

### Installation Steps
1. **Drag Docker.app** to Applications folder
2. **Open Docker Desktop** from Applications
3. **Grant permissions** when prompted (admin password required)
4. **Sign up/Sign in** to Docker Hub (free account)
5. **Complete the tutorial** (optional but recommended)
6. Wait for Docker to start (Docker icon appears in menu bar)

### Verify Installation
Open **Terminal** and run:
```bash
docker --version
```
You should see something like: `Docker version 24.0.x`

## Step 4: Test the PhenoScript Pipeline

### Navigate to Project Folder
```bash
# Open Terminal and navigate to your project
cd ~/Desktop/intro-phenoscript
```

### Run the Docker Container
```bash
# Create output folder
mkdir -p student-output

# Run the PhenoScript pipeline
docker run --rm \
  -v $(pwd)/phenotypes:/app/phenotypes \
  -v $(pwd)/student-output:/app/docker-output \
  sergeit215/phenoscript-nl-converter:latest
```

### Check Results
```bash
# Open the output folder in Finder
open student-output/output-NL/
```

You should see HTML files with natural language descriptions!

## Step 5: Edit Your Species Description

### Open the Description File
```bash
# Open the file in your default text editor
open phenotypes/descriptions.phs

# Or use a specific editor:
nano phenotypes/descriptions.phs          # Simple terminal editor
code phenotypes/descriptions.phs          # VS Code (if installed)
```

### Edit in Finder (GUI Method)
1. Open **Finder**
2. Navigate to `Desktop/intro-phenoscript/phenotypes/`
3. Double-click `descriptions.phs`
4. Edit in TextEdit or your preferred editor
5. Save the file

### Run Again with Your Changes
```bash
# Run the pipeline again
docker run --rm \
  -v $(pwd)/phenotypes:/app/phenotypes \
  -v $(pwd)/student-output:/app/docker-output \
  sergeit215/phenoscript-nl-converter:latest

# View your new results
open student-output/output-NL/
```

## 🚨 Troubleshooting

### Docker Issues

**"Docker command not found"**
- Make sure Docker Desktop is running (check menu bar for whale icon)
- Restart Terminal after installing Docker
- Try: `/Applications/Docker.app/Contents/Resources/bin/docker --version`

**"Cannot connect to the Docker daemon"**
- Start Docker Desktop from Applications
- Wait for it to fully start (whale icon stops animating)

**"Permission denied" errors**
- Make sure you gave Docker the required permissions during setup
- Try running Docker Desktop as administrator

### Mac-Specific Issues

**"Developer cannot be verified" (macOS security)**
1. Go to **System Preferences** → **Security & Privacy**
2. Click **Allow** for Docker
3. Enter your password

**Apple Silicon (M1/M2/M3) compatibility**
- Make sure you downloaded the "Apple Chip" version of Docker
- Some older Docker images might run slower (but will work)

**Rosetta 2 required**
```bash
# Install Rosetta 2 if prompted
softwareupdate --install-rosetta
```

### Terminal Tips for Mac Users

**Navigate to folders:**
```bash
cd ~/Desktop                    # Go to Desktop
cd ~/Downloads                  # Go to Downloads
pwd                            # Show current folder
ls                             # List files in current folder
```

**File permissions:**
```bash
# If you get permission errors, try:
sudo chown -R $(whoami) student-output/
```

## 📁 Folder Structure After Setup

```
Desktop/intro-phenoscript/
├── phenotypes/
│   ├── descriptions.phs          ← Edit this file!
│   ├── example-Scarabaeus.phs
│   └── phs-config.yaml
├── student-output/               ← Your results appear here
│   ├── output-NL/               ← HTML descriptions
│   └── output/                  ← OWL files
├── docs/                        ← Course documentation
└── README.md                    ← Course overview
```

## 💡 Pro Tips for Mac Users

### Using Terminal More Effectively
```bash
# Auto-complete with Tab key
cd Des[Tab] → cd Desktop/

# Use up/down arrows to repeat previous commands

# Clear terminal screen
clear

# Open current folder in Finder
open .
```

### Text Editors for Mac
- **TextEdit**: Built-in, simple
- **VS Code**: Free, powerful, great for coding
- **Sublime Text**: Fast and lightweight
- **nano**: Terminal-based, always available

### Keyboard Shortcuts
- **⌘+Space**: Spotlight search (find applications)
- **⌘+Tab**: Switch between applications
- **⌘+C / ⌘+V**: Copy/Paste in Terminal

## ✅ Success Checklist

- [ ] Git installed and working
- [ ] Repository downloaded to your computer
- [ ] Docker Desktop installed and running
- [ ] Docker command works in Terminal
- [ ] Successfully ran the PhenoScript pipeline
- [ ] Can see HTML output files in Finder
- [ ] Can edit and re-run with your own descriptions

## 🆘 Need More Help?

- **Docker Desktop for Mac**: https://docs.docker.com/desktop/mac/
- **Mac Terminal Guide**: https://support.apple.com/guide/terminal/
- **Git on Mac**: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
- **Course Issues**: Create an issue on GitHub or ask your instructor

---

**Next Steps**: Once everything is working, check out [Writing Species Descriptions](WRITING-DESCRIPTIONS.md) to learn PhenoScript syntax!