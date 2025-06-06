# The Little Book of Smiley Plots: A collection of ancient DNA damage plots and their causes

This repository contains a examples of different types of ancient DNA damage plots, both valid and invalid, and describes the causes behind them.

## Technical guidelines

To add a new plot:

1. add a new `.qmd` markdown file (make a copy of `template.qmd` if you wish)
2. add the name of the file to the corresponding 'part' in `_quarto.yml`.
3. raw deamination plot data file(s) (e.g. from mapDamage or DamageProfiler) for the corresponding plot should be added to the `assets/data/` folder in a subfolder named the same as the `.qmd` file.
4. new functions for parsing new damage profile tool outputs in `assets/src/R/`
5. caricature image should go in `assets/images/` in a folder also with the same name as the `.qmd`, but with the file name the 'name' of the caricature.
6. bibtex citations should go in `references.bib`

## Artistic guidelines

We want to give the artists of caricatures as much stylistic and creative freedom as possible. The five specifications for the caricatures are:

1. The perceived 'quality' of the art is **not** important(!)
2. They must be a caricature of a face (neither species, nor realism are important - but in most cases do not images of living people)
3. Must incorporate a damage profiles into it (of those that do not have one in the book already - please assign/leave a comment on the respective [GitHub issue](https://github.com/SPAAM-community/little-book-of-smiley-plots/issues)!)
4. Other than gray scale (black, white, shades of grey), can only use three colours: red, blue, and one additional your choice
5. Must not violate the [SPAAM code of conduct](https://spaam-community.org/code-of-conduct/)(i.e, not contain sexist, racist, homophobic illegal, defamatory, rude, imagery etc.)

Additional recommendations:

- The image should be shared in vector format (to allow resizing), if possible

## Development Guidelines

Once changes to the _markdown_ contents are made, you can preview locally, but you must re-render the book before pushing.

- To preview: `quarto preview . --no-browser --no-watch-inputs`
- To re-render: `quarto render --to all`
- Then git commit and push

> [!WARNING]
> If changes are made to _R_ code (e.g. under `src/R`), you MUST re-render _before_ live previewing!
> While markdown changes can be updated on the fly, R-code generated images are not updated in real time.
