@echo off
REM PhenoScript Course - Easy Run Script for Windows
REM This script makes it easy for students to run the conversion pipeline

echo 🔬 PhenoScript Course - Species Description Converter
echo ==================================================

REM Check if Docker is available
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not running!
    echo Please start Docker Desktop and try again.
    pause
    exit /b 1
)

echo ✅ Docker is running

REM Check if phenotypes directory exists
if not exist "phenotypes" (
    echo ❌ Cannot find phenotypes directory!
    echo Make sure you're running this script from the intro-phenoscript folder.
    pause
    exit /b 1
)

echo ✅ Found phenotypes directory

REM Check if descriptions.phs exists
if not exist "phenotypes\descriptions.phs" (
    echo ⚠️ No descriptions.phs found.
    echo Creating one from template...
    if exist "phenotypes\student-template.phs" (
        copy "phenotypes\student-template.phs" "phenotypes\descriptions.phs" >nul
        echo ✅ Created descriptions.phs from template
        echo 📝 Please edit phenotypes\descriptions.phs with your species description
        echo Then run this script again.
        pause
        exit /b 0
    ) else (
        echo ❌ Template file not found. Please create descriptions.phs manually.
        pause
        exit /b 1
    )
)

echo ✅ Found descriptions.phs

REM Create output directory
if not exist "student-output" mkdir "student-output"
echo ✅ Created output directory

echo.
echo 🚀 Starting conversion...
echo This may take a minute to download the Docker image on first run...

REM Run the Docker container
docker run --rm -v "%cd%/phenotypes:/app/phenotypes" -v "%cd%/student-output:/app/docker-output" sergeit215/phenoscript-nl-converter:latest

REM Check if conversion succeeded
if %errorlevel% equ 0 (
    echo.
    echo 🎉 Conversion completed successfully!
    echo.
    echo 📁 Your results are in:
    echo    - student-output\output-NL\     (HTML natural language descriptions^)
    echo    - student-output\output\        (OWL ontology files^)
    echo.
    
    REM Try to open results automatically
    echo 🌐 Opening results in Explorer...
    explorer "student-output\output-NL"
    
    echo.
    echo 📖 To modify your description:
    echo    1. Edit phenotypes\descriptions.phs
    echo    2. Run this script again
    echo.
) else (
    echo.
    echo ❌ Conversion failed!
    echo Check the error messages above.
    echo Common issues:
    echo    - Syntax errors in descriptions.phs
    echo    - Missing commas or brackets
    echo    - Docker not running properly
    echo.
    echo See docs\DOCKER-TROUBLESHOOTING.md for help
)

pause