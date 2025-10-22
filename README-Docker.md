# PhenoScript NL Converter Docker

This Docker setup provides a lightweight container for converting PhenoScript (PHS) files to Natural Language (NL) format using the `phenospy` tool.

## Quick Start

### Using Docker Compose (Recommended)

```bash
# Clone the repository
git clone https://github.com/sergeitarasov/intro-phenoscript.git
cd intro-phenoscript

# Run the conversion
docker-compose -f docker-compose.nl.yml up

# Check results in docker-output folder
ls docker-output/
```

### Using Docker directly

```bash
# Build the image
docker build -f Dockerfile.nl -t phenoscript-nl .

# Run the conversion
docker run --rm -v $(pwd)/docker-output:/app/docker-output phenoscript-nl

# Check results
ls docker-output/
```

### Using Pre-built Image from Docker Hub

```bash
# Pull and run the pre-built image
docker run --rm \
  -v $(pwd)/phenotypes:/app/phenotypes \
  -v $(pwd)/docker-output:/app/docker-output \
  sergeit215/phenoscript-nl-converter:latest
```

## What it does

The Docker container performs the following steps:

1. **PHS to OWL**: Converts PhenoScript files to OWL ontology format
2. **OWL to NL**: Converts the OWL ontology to Natural Language (HTML format)
3. **Copy outputs**: Copies the generated files to `docker-output/` folder

## Input/Output

### Input
- **phenotypes/descriptions.phs**: Main PhenoScript file
- **phenotypes/**: Directory containing PhenoScript configuration and files

### Output
The container creates a `docker-output/` folder with:
- **output-NL/**: Natural language HTML files
- **output/**: OWL ontology files

## Customization

### Using different input files

You can modify the PHS_FILE variable in the Makefile or mount your own phenotypes directory:

```bash
docker run --rm \
  -v /path/to/your/phenotypes:/app/phenotypes \
  -v $(pwd)/docker-output:/app/docker-output \
  phenoscript-nl
```

### Building for different architectures

```bash
# Build for ARM64 (Apple Silicon)
docker buildx build --platform linux/arm64 -f Dockerfile.nl -t phenoscript-nl .

# Build for AMD64 (Intel)
docker buildx build --platform linux/amd64 -f Dockerfile.nl -t phenoscript-nl .

# Build for both platforms
docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile.nl -t phenoscript-nl .
```

## Publishing to Docker Hub

1. **Build and tag the image:**
   ```bash
   ./docker-build-push.sh your-dockerhub-username
   ```

2. **Login to Docker Hub:**
   ```bash
   docker login
   ```

3. **Push the image:**
   ```bash
   docker push sergeit215/phenoscript-nl-converter:latest
   ```

## Automated Builds with GitHub Actions

The repository includes a GitHub Actions workflow that automatically builds and pushes to Docker Hub when you push to the main branch.

### Setup:
1. Add these secrets to your GitHub repository:
   - `DOCKER_USERNAME`: Your Docker Hub username
   - `DOCKER_PASSWORD`: Your Docker Hub access token

2. Update the `DOCKER_USERNAME` in `.github/workflows/docker-build.yml`

3. Push to main branch or create a tag to trigger the build

## Requirements

- Docker
- Docker Compose (optional, for easier usage)

## Image Details

- **Base Image**: `python:3.9-slim`
- **Size**: ~200MB (much smaller than the full pipeline)
- **Installed Packages**: `phenospy`, `make`
- **Architecture**: Supports both AMD64 and ARM64

## Troubleshooting

### Permission Issues
If you encounter permission issues with output files:
```bash
# Fix ownership of output files
sudo chown -R $(whoami):$(whoami) docker-output/
```

### Container doesn't start
Check if the phenotypes directory exists and contains the required files:
```bash
ls phenotypes/descriptions.phs
```

### Build fails
Ensure you have enough disk space and a stable internet connection for downloading dependencies.

## Development

To modify the conversion process:

1. Edit the Makefile targets
2. Rebuild the Docker image
3. Test locally before pushing

```bash
# Rebuild after changes
docker build -f Dockerfile.nl -t phenoscript-nl .

# Test
docker run --rm -v $(pwd)/docker-output:/app/docker-output phenoscript-nl
```