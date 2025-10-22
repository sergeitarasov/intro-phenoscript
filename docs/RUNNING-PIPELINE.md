# Running the PhenoScript Pipeline

## 🚀 Converting Your Species Description

Once you've written your species description in `phenotypes/descriptions.phs`, it's time to convert it to natural language!

## Method 1: Using Docker (Recommended)

### For Mac/Linux:
```bash
# Navigate to your project folder
cd ~/Desktop/intro-phenoscript  # or wherever you saved it

# Create output directory
mkdir -p student-output

# Run the conversion
docker run --rm \
  -v $(pwd)/phenotypes:/app/phenotypes \
  -v $(pwd)/output:/app/docker-output \
  sergeit215/phenoscript-nl-converter:latest

# View results
open output/output-NL/    # Mac
xdg-open output/output-NL/  # Linux
```

### For Windows:
```cmd
# Navigate to your project folder (in Command Prompt)
cd Desktop\intro-phenoscript

# Create output directory
mkdir output

# Run the conversion
docker run --rm -v %cd%/phenotypes:/app/phenotypes -v %cd%/output:/app/docker-output sergeit215/phenoscript-nl-converter:latest

# View results
explorer output\output-NL
```

## Method 2: Using Docker Compose (Alternative)

If you prefer using Docker Compose:

```bash
# Run with docker-compose
docker-compose -f docker-compose.student.yml up

# View results
open output/output-NL/    # Mac
explorer output\output-NL  # Windows
xdg-open output/output-NL/  # Linux
```

## 📊 What Happens During Conversion

The pipeline performs these steps:

1. **PHS → XML**: Converts your PhenoScript to structured XML
2. **XML → OWL**: Creates an OWL ontology (knowledge graph)
3. **OWL → Natural Language**: Generates human-readable HTML descriptions

### Expected Output

You should see output like this:
```
STEP: phs TO OWL
Executing phs2owl ... 
Reading Phenoscript file: descriptions.phs
Good! File is read!
Checking if parentheses are balanced...
Good! Parentheses are balanced.
...
Converting XML to OWL...
Done!

STEP: phs TO NL
Reading OWL: output/des_phenoscript.owl
Adding absence traits...
Adding presence traits...
...
Done!

STEP: Copying NL outputs to docker-output
NL output directories copied to docker-output/
```

## 📁 Understanding Your Results

After successful conversion, you'll find:

```
output/
├── output-NL/
│   └── org_[YourSpeciesName].html    ← Natural language description!
└── output/
    ├── des_phenoscript.owl           ← OWL ontology
    └── des_phenoscript.xml           ← XML intermediate file
```

### The Natural Language File

The main result is the HTML file in `output-NL/`. This file contains:
- **Structured natural language** describing your species
- **Organized by anatomical parts**
- **Professional scientific language**
- **Readable in any web browser**

## 🔄 Iterating Your Description

### Common Workflow:
1. **Edit** `phenotypes/descriptions.phs`
2. **Run** the pipeline
3. **Review** the generated HTML
4. **Refine** your PhenoScript based on results
5. **Repeat** until satisfied

### Tips for Iteration:
- **Start simple**: Begin with basic anatomical structures
- **Add detail gradually**: Expand descriptions over time
- **Check output**: Does the generated text make sense?
- **Compare examples**: Look at the provided example files

## 🚨 Troubleshooting

### Common Issues

**"No such file or directory"**
- Make sure you're in the right folder (`intro-phenoscript`)
- Check that `phenotypes/descriptions.phs` exists
- Use `ls` (Mac/Linux) or `dir` (Windows) to verify files

**"Syntax error in PhenoScript file"**
- Check for missing commas, brackets, or parentheses
- Ensure proper nesting of anatomical structures
- Look for typos in trait names

**"Docker command not found"**
- Make sure Docker Desktop is running
- Restart your terminal after installing Docker
- Try the full Docker path if needed

**"Permission denied"**
- On Linux: Make sure you're in the docker group
- On Mac/Windows: Ensure Docker has proper permissions

### Debugging Your PhenoScript

If the conversion fails, check your syntax:

```phenoscript
// Good syntax:
head(
    shape(round),
    color(black)
)

// Bad syntax (missing comma):
head(
    shape(round)
    color(black)  // ← Missing comma above!
)

// Bad syntax (wrong brackets):
head[              // ← Should be parentheses
    shape(round)
]
```

## 📈 Advanced Usage

### Running Multiple Times
The pipeline is designed to be run multiple times. Each run overwrites previous results, so you can experiment freely.

### Comparing Results
Try creating multiple versions:
```bash
# Run once
docker run --rm -v $(pwd)/phenotypes:/app/phenotypes -v $(pwd)/output-v1:/app/docker-output sergeit215/phenoscript-nl-converter:latest

# Edit descriptions.phs, then run again
docker run --rm -v $(pwd)/phenotypes:/app/phenotypes -v $(pwd)/output-v2:/app/docker-output sergeit215/phenoscript-nl-converter:latest

# Compare version1/ and version2/ results
```

## 💡 Pro Tips

1. **Save your work frequently** - Edit and test in small increments
2. **Use version control** - Git can track changes to your PhenoScript files
3. **Start with examples** - Modify existing examples before writing from scratch
4. **Test early and often** - Run the pipeline frequently during development
5. **Read the output** - The generated text reveals issues with your descriptions

## ✅ Success Indicators

You've successfully run the pipeline when:
- [ ] Docker command completes without errors
- [ ] `output/` directory is created
- [ ] HTML file appears in `output/output-NL/`
- [ ] HTML file opens in browser and shows readable text
- [ ] Generated description matches your input species

---

**Next Step**: Check out [Understanding Results](UNDERSTANDING-RESULTS.md) to learn how to interpret and improve your generated descriptions!