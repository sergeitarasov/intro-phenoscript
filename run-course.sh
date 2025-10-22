#!/bin/bash

# PhenoScript Course - Easy Run Script
# This script makes it easy for students to run the conversion pipeline

echo "🔬 PhenoScript Course - Species Description Converter"
echo "=================================================="

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running!"
    echo "Please start Docker Desktop and try again."
    exit 1
fi

echo "✅ Docker is running"

# Check if phenotypes directory exists
if [ ! -d "phenotypes" ]; then
    echo "❌ Cannot find phenotypes directory!"
    echo "Make sure you're running this script from the intro-phenoscript folder."
    exit 1
fi

echo "✅ Found phenotypes directory"

# Check if descriptions.phs exists
if [ ! -f "phenotypes/descriptions.phs" ]; then
    echo "⚠️  No descriptions.phs found."
    echo "Creating one from template..."
    if [ -f "phenotypes/student-template.phs" ]; then
        cp "phenotypes/student-template.phs" "phenotypes/descriptions.phs"
        echo "✅ Created descriptions.phs from template"
        echo "📝 Please edit phenotypes/descriptions.phs with your species description"
        echo "Then run this script again."
        exit 0
    else
        echo "❌ Template file not found. Please create descriptions.phs manually."
        exit 1
    fi
fi

echo "✅ Found descriptions.phs"

# Create output directory
mkdir -p student-output
echo "✅ Created output directory"

echo ""
echo "🚀 Starting conversion..."
echo "This may take a minute to download the Docker image on first run..."

# Run the Docker container
docker run --rm \
    -v "$(pwd)/phenotypes:/app/phenotypes" \
    -v "$(pwd)/student-output:/app/docker-output" \
    sergeit215/phenoscript-nl-converter:latest

# Check if conversion succeeded
if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 Conversion completed successfully!"
    echo ""
    echo "📁 Your results are in:"
    echo "   - student-output/output-NL/     (HTML natural language descriptions)"
    echo "   - student-output/output/        (OWL ontology files)"
    echo ""
    
    # Try to open results automatically
    if command -v open > /dev/null; then
        # macOS
        echo "🌐 Opening results in Finder..."
        open student-output/output-NL/
    elif command -v xdg-open > /dev/null; then
        # Linux
        echo "🌐 Opening results in file manager..."
        xdg-open student-output/output-NL/
    else
        echo "💡 Open student-output/output-NL/ to see your results"
    fi
    
    echo ""
    echo "📖 To modify your description:"
    echo "   1. Edit phenotypes/descriptions.phs"
    echo "   2. Run this script again"
    echo ""
else
    echo ""
    echo "❌ Conversion failed!"
    echo "Check the error messages above."
    echo "Common issues:"
    echo "   - Syntax errors in descriptions.phs"
    echo "   - Missing commas or brackets"
    echo "   - Docker not running properly"
    echo ""
    echo "See docs/DOCKER-TROUBLESHOOTING.md for help"
fi