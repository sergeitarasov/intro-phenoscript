# PhenoScript Docker Pipeline

This Docker setup allows you to run the entire PhenoScript pipeline in a containerized environment, ensuring reproducibility and easy deployment.

## Quick Start

### Option 1: Using the convenience script
```bash
./run-docker.sh
```

### Option 2: Using Docker directly
```bash
# Build the image
docker build -t phenoscript-pipeline .

# Run the pipeline
docker run --rm -v "$(pwd)/docker-output:/app/docker-output" phenoscript-pipeline
```

### Option 3: Using Docker Compose
```bash
# Build and run
docker-compose up --build

# Clean up
docker-compose down
```

## What it does

The Docker pipeline:

1. **Copies** the entire project directory into the container
2. **Installs** all required dependencies:
   - Python 3 with phenospy package
   - Java 11 for Apache Jena tools
   - pyshacl for SHACL validation
   - materializer for reasoning
   - Apache Jena for RDF processing
3. **Runs** the complete Makefile pipeline:
   - Converts PHS files to OWL format
   - Generates natural language descriptions
   - Validates using SHACL
   - Performs reasoning with materializer
   - Creates final merged ontologies
4. **Copies** all output directories back to the host

## Output

After running, you'll find three directories in `docker-output/`:

- **`output/`** - Contains the main OWL files and processed ontologies
- **`output-NL/`** - Contains natural language HTML descriptions
- **`log/`** - Contains log files from validation and reasoning steps

## Requirements

- Docker installed on your system
- At least 2GB of available disk space
- Internet connection (for downloading ontologies during build)

## Troubleshooting

### Build Issues
If the Docker build fails:
```bash
# Clean Docker cache and rebuild
docker system prune -a
docker build --no-cache -t phenoscript-pipeline .
```

### Permission Issues
If you get permission errors with output files:
```bash
# Fix ownership of output directory
sudo chown -R $USER:$USER docker-output/
```

### Interactive Debugging
To debug issues inside the container:
```bash
# Run container interactively
docker run -it --rm -v "$(pwd)/docker-output:/app/docker-output" phenoscript-pipeline /bin/bash

# Then inside the container, you can run commands manually:
cd /app/main
make phs2-owl-NL
```

## Customization

### Modifying the Pipeline
To modify what the pipeline does, edit the `Makefile` in the `main/` directory. The Docker setup will automatically use your changes.

### Different Input Files
The pipeline uses the files specified in the `Makefile` variables. To process different files, either:
1. Replace the files in the `phenotypes/` directory, or
2. Modify the `PHS_FILE` variable in the `Makefile`

### Additional Dependencies
If you need additional tools, modify the `Dockerfile` to install them in the appropriate section.

## File Structure

```
intro-phenoscript/
├── Dockerfile              # Main Docker image definition
├── docker-compose.yml      # Docker Compose configuration
├── .dockerignore           # Files to exclude from Docker build
├── run-docker.sh           # Convenience script to build and run
├── main/
│   ├── Makefile            # Pipeline definition (now with docker-all target)
│   ├── phenotypes/         # Input PHS files
│   ├── source_ontologies/  # Required ontology files
│   └── utils/              # SPARQL queries and validation rules
└── docker-output/          # Created after running - contains results
    ├── output/             # Main OWL outputs
    ├── output-NL/          # Natural language descriptions
    └── log/                # Processing logs
```