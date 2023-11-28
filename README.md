
# Opol-GSMM: Genome scale metabolic model of *Ogataea polymorpha*


## Description

### Original Genome Scale Metabolic Model
*Ogataea polymorpha* is a thermotolerant, methylotrophic yeast with significant industrial applications. While previously mainly used for protein synthesis, it also holds promise for producing platform chemicals. _O. polymorpha_ holds the distinct advantage of using methanol as a substrate, which could be potentially derived from carbon capture and utilization streams. Full development of the organism into a production strain and estimation of the metabolic capabilities require additional strain design, guided by metabolic modeling with a genome-scale metabolic model. However, to date, no genome-scale metabolic model is available for *O. polymorpha*.

To overcome this limitation, we used a published reconstruction of the closely related yeast *Komagataella phaffii* as a reference and corrected reactions based on KEGG and MGOB annotation.  Additionally, we conducted phenotype microarray experiments to test the suitability of 190 substrates as carbon sources. Over three-quarter of the substrate use was correctly reproduced by the model and 27 new substrates were added, that were not present in the *K. phaffii* reference model. 

The developed genome-scale metabolic model of *O. polymorpha* will support the engineering of synthetic metabolic capabilities and enable the optimization of production processes, thereby supporting a sustainable future methanol economy.


### Citation

Liebal, UW., Fabry, BA., Ravikrishnan A., Schedel, CVL., Schmitz, S., Blank, LM., Ebert, BE. (2020). Genome-scale model reconstruction of the methylotrophic yeast *Ogataea polymorpha*. under revision



<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.

---

### Methanol bioconversion into C3, C4, and C5 platform chemicals by the yeast *Ogataea polymorpha*
*Ogataea polymorpha* has the potential to produce useful chemicals from methanol, a C1 carbon molecule that can be sourced sustainably from CO<sub>2</sub> and green hydrogen. Our focus was on generating acetone, malate, and isoprene as examples of industrially relevant products with different carbon atom counts. We successfully modified *O. polymorpha* to produce these compounds using methanol as a carbon source. Notably, we found that *O. polymorpha* is well-suited for malate production, and introducing an efficient malate transporter is crucial for this process. Through optimizing cultivation conditions, we achieved high yields of malate (13 g/L) and demonstrated the production of acetone and isoprene as well. These results suggest *O. polymorpha* could be a versatile tool for producing various biochemicals from methanol, contributing to our understanding of using methylotrophic yeasts for sustainable chemical production. This study can guide future efforts in metabolic engineering and process optimization for producing platform chemicals from renewable C1 carbon sources. 

The simulations for this work have bee done with the Jupyter Notebook [code/Model-Analysis.ipynb](code/Model-Analysis.ipynb) associated data of this work is located in the subfolder [data/MethanolBioconversion](data/MethanolBioconversion). 

### Citation

Wefelmeier, K., Schmitz, S., Kösters, B.J., Liebal, U.W., Blank, LM.Methanol bioconversion into C3, C4, and C5 platform chemicals by the yeast *Ogataea polymorpha*. submitted and under revision

---

## Keywords

Biotechnology; Genome-Scale metabolic model; Metabolic reconstruction; Metabolic engineering; COBRA; Methylotrophy



**Utilisation:** experimental data reconstruction; _in silico_ strain design; model template 
**Field:** metabolic reactions only
**Type of model:** comparative; curated
**Model source:** [iMT1026v3](http://doi.org/10.1111/1751-7915.12871) 
**Omic source:** genomics
**Taxonomy:** Eurkaryota, Fungi, Dikarya, Ascomycota, Saccharomycotina, Saccharomycetes, Saccharomycetales, Pichiaceae, Ogataea, Ogataea polymorpha

**Metabolic system:** general metabolism, methylotrophy
**Tissue:**  NA

**Bioreactor:**  Batch, Chemostat 
**Cell type:**  NA

**Cell line:**  NA

**Strain:** NCYC495 
**Condition:** aerobic; glucose-limited; methanol-limited, defined media


### Installation

Due to license agreements the model is not freely available. However, we are happy to send you the model by mail:

lars.blank(at)rwth-aachen.de

ulf.liebal(at)rwth-aachen.de


### Usage

Use the Jupyter Notebooks in the `code` directory.

