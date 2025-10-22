# Lightweight Docker image for PhenoScript PHS to NL conversion
FROM python:3.9-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Install system dependencies (minimal)
RUN apt-get update && apt-get install -y \
    make \
    && rm -rf /var/lib/apt/lists/*

# Install phenospy
RUN pip install --no-cache-dir phenospy

# Create working directory
WORKDIR /app

# Copy the entire project directory
COPY . /app/

# Create docker-output directory
RUN mkdir -p /app/docker-output

# Change to main directory for running make
WORKDIR /app/main

# Default command - run only PHS to NL conversion and copy outputs
CMD make docker-nl && \
    echo "PHS to NL conversion completed! Check docker-output folder for results."