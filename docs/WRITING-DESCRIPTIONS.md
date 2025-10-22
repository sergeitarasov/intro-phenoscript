# Writing Species Descriptions with PhenoScript

## 📝 Introduction to PhenoScript

PhenoScript is a structured language for describing morphological features of organisms. It allows you to create precise, computer-readable descriptions that can be converted to ontologies and natural language.

## 🔧 Basic Syntax

### Structure of a PhenoScript File

Every PhenoScript file follows this basic structure:

```phenoscript
// Comments start with double slashes

OTU = { 
    // OTUName: Your Species Name
    
    // Your morphological descriptions go here
    
}
```

### Key Components

1. **OTU Block**: Operational Taxonomic Unit (your species)
2. **Comments**: Use `//` for comments and species names
3. **Traits**: Morphological features and their states
4. **Anatomy**: Body parts and structures
5. **Measurements**: Quantitative data

## 📖 Learning from the Example

Let's examine the example file `phenotypes/example-Scarabaeus.phs`:

```phenoscript
OTU = { #// OTUName:  Scarabaeus viettei

    ANATOMY = {
        
        head(
            shape(oblong),
            
            antenna = {
                COUNT(2),
                shape(club-shaped),
                
                antennomere_count = {
                    COUNT(10)
                }
            }
        ),
        
        prothorax = {
            
            pronotum(
                punctation(punctured),
                punctation_density(dense)
            )
        },
        
        abdomen = {
            
            pygidium(
                punctation(punctured),
                punctation_density(sparse)
            )
        }
        
    }

}
```

### Understanding the Structure

1. **Main OTU block** contains all descriptions
2. **ANATOMY block** describes body parts
3. **Nested structures** show part-of relationships
4. **Traits in parentheses** describe features
5. **COUNT() function** for quantitative data

## ✏️ Your Assignment: Write a Species Description

### Step 1: Choose Your Species

Pick any organism you're familiar with:
- An insect (beetle, butterfly, ant)
- A plant (tree, flower, grass)
- A vertebrate (bird, fish, mammal)
- Any organism with observable features

### Step 2: Plan Your Description

Think about:
- **Body parts**: What are the main anatomical structures?
- **Shapes**: Round, oval, elongated, triangular?
- **Colors**: What colors are visible?
- **Textures**: Smooth, rough, hairy, scaled?
- **Sizes**: Any countable or measurable features?

### Step 3: Edit the Description File

1. Open `phenotypes/descriptions.phs`
2. Replace the example with your own species
3. Follow the syntax patterns from the example

### Example Template

```phenoscript
OTU = { #// OTUName: [Your Species Name]

    ANATOMY = {
        
        [body_part_1](
            shape([shape_description]),
            color([color_description]),
            texture([texture_description])
        ),
        
        [body_part_2] = {
            COUNT([number]),
            
            [sub_part](
                [trait_1]([state_1]),
                [trait_2]([state_2])
            )
        }
        
    }

}
```

## 🦋 Example: Monarch Butterfly

Here's how you might describe a Monarch butterfly:

```phenoscript
OTU = { #// OTUName: Danaus plexippus

    ANATOMY = {
        
        head(
            shape(rounded),
            color(black),
            
            antenna = {
                COUNT(2),
                shape(clubbed),
                color(black)
            },
            
            eye = {
                COUNT(2),
                shape(compound),
                color(dark)
            }
        ),
        
        thorax(
            color(black),
            texture(spotted),
            
            wing = {
                COUNT(4),
                color(orange),
                pattern(veined),
                
                wing_border(
                    color(black),
                    texture(spotted)
                )
            },
            
            leg = {
                COUNT(6),
                color(black)
            }
        ),
        
        abdomen(
            shape(elongated),
            color(orange),
            pattern(striped)
        )
        
    }

}
```

## 🌳 Example: Oak Tree

Here's how you might describe an oak tree:

```phenoscript
OTU = { #// OTUName: Quercus robur

    ANATOMY = {
        
        trunk(
            shape(cylindrical),
            texture(rough),
            color(brown),
            
            bark(
                texture(furrowed),
                color(gray-brown)
            )
        ),
        
        branch = {
            texture(smooth),
            color(brown),
            
            leaf = {
                shape(lobed),
                color(green),
                texture(smooth),
                margin(toothed)
            }
        },
        
        root_system(
            architecture(spreading),
            depth(deep)
        )
        
    }

}
```

## 🎯 Tips for Success

### DO:
- ✅ Use descriptive anatomical terms
- ✅ Be consistent with naming conventions
- ✅ Use underscores for multi-word terms (`wing_border`)
- ✅ Include quantitative data with COUNT()
- ✅ Nest related structures logically

### DON'T:
- ❌ Use spaces in trait names (use underscores)
- ❌ Forget commas between traits
- ❌ Mix up parentheses `()` and braces `{}`
- ❌ Use special characters (@, #, %, etc.) except in comments

### Common Patterns

**For countable structures:**
```phenoscript
antenna = {
    COUNT(2),
    shape(clubbed)
}
```

**For color patterns:**
```phenoscript
wing(
    color(orange),
    pattern(striped),
    border_color(black)
)
```

**For nested anatomy:**
```phenoscript
head(
    eye = {
        COUNT(2),
        shape(compound)
    },
    
    antenna = {
        COUNT(2),
        length(long)
    }
)
```

## 🔄 Testing Your Description

After writing your description:

1. **Save the file** (`descriptions.phs`)
2. **Run the pipeline**:
   ```bash
   docker run --rm \
     -v $(pwd)/phenotypes:/app/phenotypes \
     -v $(pwd)/student-output:/app/docker-output \
     sergeit215/phenoscript-nl-converter:latest
   ```
3. **Check results** in `student-output/output-NL/`
4. **Iterate and improve** based on the output

## 🎓 Assignment Deliverables

1. **Your PhenoScript file** (`descriptions.phs`) with original species description
2. **Generated HTML file** from the pipeline
3. **Brief comparison**: How does the generated natural language compare to how you would describe the species in plain English?

## 🆘 Need Help?

- **Syntax errors**: Check brackets, commas, and parentheses
- **Ideas for traits**: Look at the example files for inspiration
- **Anatomical terms**: Use simple, descriptive terms
- **Structure questions**: Follow the nesting patterns in examples

---

**Next Step**: Once you've written your description, proceed to [Running the Pipeline](RUNNING-PIPELINE.md) to convert it to natural language!