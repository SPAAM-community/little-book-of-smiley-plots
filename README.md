# The Little Book of Smiley Plots: A collection of ancient DNA damage plots and their causes

This repository contains a examples of different types of ancient DNA damage plots, both valid and invalid, and describes the causes behind them.

To add a new plot:

1. add a new `.qmd` markdown file (make a copy of `template.qmd` if you wish)
2. add the name of the file to the corresponding 'part' in `_quarto.yml`.
3. raw deamination plot data file(s) (e.g. from mapDamage or DamageProfiler) for the corresponding plot should be added to the `assets/data/` folder in a subfolder named the same as the `.qmd` file.
4. caricature image should go in `assets/images/` in a folder also with the same name as the `.qmd`, but with the file name the 'name' of the caricature.
5. bibtex citations should go in `references.bib`
