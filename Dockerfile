# Use Ubuntu as base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    openjdk-11-jdk \
    wget \
    curl \
    unzip \
    make \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME and Java memory settings for materializer
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV JAVA_OPTS=-Xmx8G
ENV JVM_ARGS=-Xmx8G

# Create working directory
WORKDIR /app

# Install Python packages first (for better caching)
RUN pip3 install --no-cache-dir \
    phenospy \
    pyshacl

# Install Apache Jena
RUN wget https://archive.apache.org/dist/jena/binaries/apache-jena-4.10.0.tar.gz \
    && tar -xzf apache-jena-4.10.0.tar.gz \
    && mv apache-jena-4.10.0 /opt/jena \
    && rm apache-jena-4.10.0.tar.gz

# Add Jena to PATH
ENV PATH="/opt/jena/bin:${PATH}"

# Install materializer
RUN wget https://github.com/balhoff/materializer/releases/download/v0.2.7/materializer-0.2.7.tgz \
    && tar -xzf materializer-0.2.7.tgz \
    && mv materializer-0.2.7/bin/materializer /usr/local/bin/ \
    && chmod +x /usr/local/bin/materializer \
    && rm -rf materializer-0.2.7.tgz materializer-0.2.7

# Create shacl wrapper script for pyshacl
RUN echo '#!/bin/bash\npython3 -m pyshacl "$@"' > /usr/local/bin/shacl \
    && chmod +x /usr/local/bin/shacl

# Create update wrapper script for Jena update
RUN echo '#!/bin/bash\njena.update "$@"' > /usr/local/bin/update \
    && chmod +x /usr/local/bin/update

# Copy the entire project directory
COPY . /app/

# Create docker-output directory
RUN mkdir -p /app/docker-output

# Change to main directory
WORKDIR /app/main

# Run the makefile with docker target
CMD make docker-all && \
    echo "Pipeline completed! Check docker-output folder for results."