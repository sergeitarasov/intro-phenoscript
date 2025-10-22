# PhenoScript Course: Species Description to Natural Language

**A hands-on course for converting morphological species descriptions to natural language using PhenoScript and Docker**

## 🎯 Course Overview

In this course, you'll learn to:
1. Write structured species descriptions using PhenoScript syntax
2. Convert your descriptions to OWL ontologies 
3. Generate natural language descriptions (HTML) from your data
4. Use Docker to run the conversion pipeline on any computer

## 📋 What You'll Need

- A computer (Windows, Mac, or Linux)
- Docker installed
- A text editor
- Basic command line knowledge (we'll guide you!)

## 🚀 Quick Start for Students

### Step 1: Get the Course Materials
```bash
# Download this repository
git clone https://github.com/sergeitarasov/intro-phenoscript.git
cd intro-phenoscript
```

### Step 2: Install Docker
- **Windows**: Follow [Windows Setup Guide](docs/SETUP-WINDOWS.md)
- **Mac**: Follow [Mac Setup Guide](docs/SETUP-MAC.md)
- **Linux**: Follow [Linux Setup Guide](docs/SETUP-LINUX.md)

### Step 3: Write Your Species Description
Edit the file `phenotypes/descriptions.phs` with your own species description

### Step 4: Convert to Natural Language

#### Easy Method (Recommended for beginners):
```bash
# Mac/Linux: Run the course script
./run-course.sh

# Windows: Double-click run-course.bat
# Or run in Command Prompt: run-course.bat
```

#### Manual Method:
```bash
# Create output folder
mkdir output

### Using Pre-built Image from Docker Hub

```bash
# Pull and run the pre-built image
docker run --rm \
  -v $(pwd)/phenotypes:/app/phenotypes \
  -v $(pwd)/output:/app/docker-output \
  sergeit215/phenoscript-nl-converter:latest
```

# Check results in output folder
ls output/
```

## 📚 Course Structure

1. **[Introduction to PhenoScript](docs/PHENOSCRIPT-INTRO.md)** - Learn the syntax
2. **[Writing Species Descriptions](docs/WRITING-DESCRIPTIONS.md)** - Hands-on exercise
3. **[Running the Pipeline](docs/RUNNING-PIPELINE.md)** - Convert your work
4. **[Understanding Results](docs/UNDERSTANDING-RESULTS.md)** - Interpret outputs

## 🆘 Need Help?

- **Setup Issues**: Check the setup guides in the `docs/` folder
- **Docker Problems**: See [Docker Troubleshooting](docs/DOCKER-TROUBLESHOOTING.md)
- **PhenoScript Syntax**: See [PhenoScript Reference](docs/PHENOSCRIPT-REFERENCE.md)

## 🎓 Course Exercise

Your assignment: Describe a species of your choice using PhenoScript syntax, then use the Docker pipeline to generate natural language descriptions. Compare your original description with the generated output!

---

**💡 Tip**: This repository includes example files to help you get started. Look in the `phenotypes/` folder for examples!