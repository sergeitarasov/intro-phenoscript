#!/bin/bash

# PhenoScript Docker Pipeline Runner
# This script builds and runs the PhenoScript pipeline in Docker

set -e

echo "🐳 Building PhenoScript Docker image..."
docker build -t phenoscript-pipeline .

echo "🚀 Running PhenoScript pipeline..."
docker run --rm -v "$(pwd)/docker-output:/app/docker-output" phenoscript-pipeline

echo "✅ Pipeline completed! Results are in ./docker-output/"
echo "📁 Output directories:"
echo "   - docker-output/output/     (OWL files and main results)"
echo "   - docker-output/output-NL/  (Natural language descriptions)"  
echo "   - docker-output/log/        (Log files from processing)"