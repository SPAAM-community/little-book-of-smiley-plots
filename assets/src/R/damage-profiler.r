#######################
## Data manipulation ##
#######################

pivot_longer_freqmisincorporat <- function(x, reverse, type_colours) {
    raw_result <- x %>%
        dplyr::rename(
            insertion = `->ACGT`,
            deletion = `ACGT>-`,
            Position = Pos
        ) %>%
        filter(Position <= 14) %>%
        tidyr::pivot_longer(tidyr::contains(c(">", "insertion", "deletion")),
            names_to = "Mutation Type",
            values_to = "Frequency"
        ) %>%
        dplyr::mutate(`Mutation Type` = factor(`Mutation Type`,
            levels = rev(names(type_colours))
        ))

    if (reverse) {
        result <- raw_result %>%
            dplyr::mutate(Position = Position * -1) %>%
            mutate(end = "3p")
    } else {
        result <- raw_result %>%
            mutate(end = "5p")
    }

    return(result)
}

##############
## Plotting ##
##############

plot_longer_freqmisincorporat <- function(x, reverse, type_colours) {
    result <- ggplot2::ggplot(
        x,
        aes(
            x = Position,
            y = Frequency,
            colour = `Mutation Type`
        )
    ) +
        ggplot2::geom_line() +
        ggplot2::scale_colour_manual(
            values = type_colours,
            guide = ggplot2::guide_legend(reverse = TRUE)
        ) +
        ggplot2::facet_wrap(~end, ncol = 2) +
        ggplot2::theme_classic() +
        ggplot2::theme(
            legend.position = "none",
            panel.background = element_rect(fill = "transparent")
        ) +
        ggplot2::coord_cartesian(ylim = c(0, 0.3))

    if (reverse) {
        result <- result +
            ggplot2::scale_x_continuous(breaks = seq(0, -14, -1)) +
            ggplot2::scale_y_continuous(
                breaks = seq(0, 0.30, 0.05),
                position = "right"
            )
    } else {
        result <- result +
            ggplot2::scale_x_continuous(breaks = seq(0, 14, 1)) +
            ggplot2::scale_y_continuous(breaks = seq(0, 0.30, 0.05))
    }

    result
}
