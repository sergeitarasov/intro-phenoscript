# Define variables
PHS_FILE = descriptions.phs
OUT_FILE_OWL = des_phenoscript
CONFIG_FILE = phenotypes/phs-config.yaml


# Default target
#all: phs2-owl-NL validate-phs reason-owl
all: phs2-owl-NL reason-owl

# Docker target - runs all and copies outputs
docker-all: phs2-owl-NL reason-owl copy-docker-outputs

# Docker NL-only target - runs only PHS to NL conversion
docker-nl: phs2-owl-NL copy-nl-outputs

# Copy outputs for Docker
copy-docker-outputs:
	@echo "\nSTEP: Copying outputs to docker-output";
	@mkdir -p ../docker-output;
	@cp -r output ../docker-output/ 2>/dev/null || echo "Warning: output directory not found";
	@cp -r output-NL ../docker-output/ 2>/dev/null || echo "Warning: output-NL directory not found";
	@cp -r log ../docker-output/ 2>/dev/null || echo "Warning: log directory not found";
	@echo "Output directories copied to docker-output/";

# Copy only NL outputs for Docker (lightweight version)
copy-nl-outputs:
	@echo "\nSTEP: Copying NL outputs to docker-output";
	@mkdir -p ../docker-output;
	@cp -r output-NL ../docker-output/ 2>/dev/null || echo "Warning: output-NL directory not found";
	@cp -r output ../docker-output/ 2>/dev/null || echo "Warning: output directory not found";
	@echo "NL output directories copied to docker-output/";



# Convert phs To OWL & NL 
phs2-owl-NL:
	@echo "\nSTEP: phs TO OWL";
	cd phenotypes && phenospy phs2owl $(PHS_FILE) ../output/$(OUT_FILE_OWL)
	cd ..;
	@echo "\nSTEP: phs TO NL";
	phenospy owl2text -f 'html' -s 'org_*' -o output/$(OUT_FILE_OWL).owl -d output-NL

# Validate phs using SHACL
# validate-phs:
# 	@echo "\nSTEP: Validate using SHACL";
# 	@mkdir -p log;
# 	shacl validate --data output/$(OUT_FILE_OWL).owl --shapes utils/source_queries/phenoscript.shacl.ttl > log/shacl.log



# resaon Abox using Tbox file with materializer
# annotate inffered axioms
# merge all ontologies into a single file
# reason-owl:
# 	@echo "\nSTEP: reason using materializer";
# 	materializer file --ontology-file source_ontologies/tbox.owl --input output/$(OUT_FILE_OWL).owl --output output/$(OUT_FILE_OWL)-reasoned_raw.ttl --reasoner whelk > log/materializer.log
# 	@echo "\nSTEP: annotate inffered axioms";
# 	update --data output/$(OUT_FILE_OWL)-reasoned_raw.ttl --update utils/source_queries/annotate.ru --dump > output/$(OUT_FILE_OWL)-reasoned-annotated.ttl
# 	@echo "\nSTEP: merge all ontologies into a single file";
# 	riot output/$(OUT_FILE_OWL).owl output/$(OUT_FILE_OWL)-reasoned-annotated.ttl source_ontologies/tbox.owl > output/$(OUT_FILE_OWL)-final.ttl
# 	@echo "\nMAKE COMPLETED";