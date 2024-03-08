#=======================================
## Template for customized lollipop plot
#=======================================


# - Colour according Variable 1
# - Shape of points according Variable 2
# - Flipped coordinates
# - Bw Theme
# - Box border
# - Font family and size
# - Axis titles
# - Legend titles
# - Colour Palette


dt %>%
  ggplot(aes(x, y, colour = variable1)) +
  geom_point(aes(shape = variable2), size = 2) +
  geom_segment(aes(x = x, xend = x, y = 0, yend = y), size = 1.2) +
  coord_flip() +
  theme_bw() +
  theme(
    text = element_text(size = 25, family = "serif"),
    panel.border = element_rect(size = 2),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  ) +
  xlab("X title") +
  ylab("Y title") +
  labs(shape = "Variable 2") +
  scale_color_paletteer_d("ggsci::default_nejm", name = "Variable 1")
