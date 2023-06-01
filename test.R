library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)
library(patchwork)

type_colours <- c("C>T" = "red", "G>A" = "blue", "A>C" = "grey", "A>G" = "grey", "A>T" = "grey", "C>A" = "grey", "C>G" = "grey", "G>C" = "grey", "G>T" = "grey", "T>A" = "grey", "T>C" = "grey", "T>G" = "grey", "insertion" = "grey", "deletion" = "grey")

raw_5p_single_stranded <- readr::read_tsv("assets/data/single-stranded/5p_freq_misincorporations.txt", comment = "#")
raw_3p_single_stranded <- readr::read_tsv("assets/data/single-stranded/3p_freq_misincorporations.txt", comment = "#")

pivot_longer_freqmisincorporation <- function(x, reverse, type_colours) {
  result <- x %>%
    dplyr::rename(insertion = `->ACGT`, deletion = `ACGT>-`, Position = Pos) %>%
    tidyr::pivot_longer(tidyr::contains(c(">", "insertion", "deletion")), names_to = "Mutation Type", values_to = "Frequency") %>%
    dplyr::mutate(`Mutation Type` = factor(`Mutation Type`, levels = rev(names(type_colours))))

  if (reverse) {
    result <- result %>%
      dplyr::mutate(Position = Position * -1)
  }

  result
}

plot_longer_freqmisincorporation <- function(x, reverse, type_colours) {
  result <- ggplot2::ggplot(x, aes(x = Position, y = Frequency, colour = `Mutation Type`)) +
    ggplot2::geom_line() +
    ggplot2::scale_colour_manual(values = type_colours, guide = ggplot2::guide_legend(reverse = TRUE)) +
    ggplot2::facet_wrap(~end, ncol = 2) +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "none")

  if (reverse) {
    result <- result +
      ggplot2::scale_x_continuous(breaks = seq(0, -14, -1)) +
      ggplot2::scale_y_continuous(breaks = seq(0, 0.30, 0.05), position = "right", limits = c(0, 0.30))
  } else {
    result <- result +
      ggplot2::scale_x_continuous(breaks = seq(0, 14, 1)) +
      ggplot2::scale_y_continuous(breaks = seq(0, 0.30, 0.05), limits = c(0, 0.30))
  }

  result
}

long_5p_single_stranded <- pivot_longer_freqmisincorporation(raw_5p_single_stranded, reverse = FALSE, type_colours = type_colours) %>% mutate(end = "5p")
long_3p_single_stranded <- pivot_longer_freqmisincorporation(raw_3p_single_stranded, reverse = TRUE, type_colours = type_colours) %>% mutate(end = "3p")

smiley_5p_single_stranded <- plot_longer_freqmisincorporation(long_5p_single_stranded, reverse = FALSE, type_colours)
smiley_3p_single_stranded <- plot_longer_freqmisincorporation(long_3p_single_stranded, reverse = TRUE, type_colours)
