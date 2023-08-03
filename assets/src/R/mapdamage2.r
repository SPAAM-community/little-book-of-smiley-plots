#######################
## Data manipulation ##
#######################

## Position, Mutation Type, Frequency, end

pivot_longer_pctotfreq <- function(x, reverse, type_colours) {
    result <- x %>%
        dplyr::rename(
            Position = pos,
        ) %>%
        tidyr::pivot_longer(tidyr::contains(c(">")),
            names_to = "Mutation Type",
            values_to = "Frequency"
        ) %>%
        mutate(`Mutation Type` = gsub("(3|5)p", "", `Mutation Type`)) %>%
        dplyr::mutate(`Mutation Type` = factor(`Mutation Type`,
            levels = rev(names(type_colours))
        )) %>%
        filter(Position <= 14)

    if (reverse) {
        result <- result %>%
            dplyr::mutate(Position = Position * -1) %>%
            mutate(end = "3p")
    } else {
        result <- result %>%
            mutate(end = "5p")
    }

    result
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
