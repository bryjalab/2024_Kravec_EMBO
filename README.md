# A new mechanism of posttranslational polyglutamylation regulates phase separation and signaling of the Wnt pathway protein Dishevelled

## Authors: 
Marek Kravec, Ondrej Šedo, Jana Nedvědová, Miroslav Micka, Marie Šulcová, Kristína Gömöryová, David Potěšil, Ranjani Sri Ganji, Igor Červenka, Zbyněk Zdráhal, Jakub Harnoš, Konstantinos Tripsianes, Carsten Janke, Cyril Bařinka and Vítězslav Bryja*

*Corresponding author: bryja@sci.muni.cz

## Reproducing the data analysis from this article: **Proteomic datasets**

### Deposition of raw data to PRIDE

Raw proteomic data can be accessed using the PRIDE with identifiers [PXD034237](https://www.ebi.ac.uk/pride/archive?keyword=PXD034237) (LC-MS analysis of polyglutamylated DVL) and [PXD033548](https://www.ebi.ac.uk/pride/archive?keyword=PXD033548) (LC-MS analysis of protein complexes). 

### Setting up the Docker container for running KNIME
In case of the analysis of protein complexes, raw data were searched using the [MaxQuant](https://www.maxquant.org/) software (v. 1.6.0.16). Resulting output, the proteinGroups.txt file, was further processed using the software container environment [OmicsWorkflows](https://github.com/OmicsWorkflows) (v. 3.7.2a): the workflow is stored within this repository as 2999_publication.knwf and can be inspected using the KNIME software.

To fully reproduce the analyses, run KNIME inside the Docker container using the 3.7.2a version of Docker image:
(Note: you need to have [Docker](https://docs.docker.com/get-docker/) installed on your computer)

1) Clone [this](https://github.com/OmicsWorkflows/KNIME_docker_vnc) repository locally to your computer
2) Adjust the start_container script for the folder which will contain your KNIME workspace (e.g. workspace-folder)
3) Run the start_container script to create a docker container as follows:
`cfprot/knime:3.7.2a`, `5901`, `workspace-folder`

For more detailed instructions, please follow the tutorial [here](https://github.com/OmicsWorkflows/KNIME_docker_vnc)

### KNIME workflow import and description

Download the KNIME workflow (2999_publication.knwf) and import it into KNIME (`File` -> `Import KNIME workflow`). 

Run the particular nodes by right-clicking the node and `Execute` or directly pressing `F7`. 
Briefly, the workflow is as following:

* Data input (proteinGroups.txt file)
* Contaminants filtering (cRAP, Reverse, Only identified by Site)
* log2 transformation of protein intensities
* LoessF normalization
* Imputation of missing values by the global minimum
* Statistical testing using the limma test
* Exporting the results as .txt file 

The resulting output (for_volcano_plots_updated.txt) can be the directly used as an input for volcano_plot.script and run within R (version 3.6.1). 


## Statistical analysis of DVL3 subcellular localization

Statistical analysis of DVL3 subcellular localization (puncta vs even phenotypes) was carried out in R (version 3.6.1) - it can be reproduced using the polyE_data.txt file as an input, and analysis_polyE_data.R script.
