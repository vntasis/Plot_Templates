# A choropleth map displays divided geographical areas or regions that are
# coloured in relation to a numeric variable.  It allows to study how a
# variable evolutes along a territory. However, its downside is that regions
# with bigger sizes tend to have a bigger weight in the map interpretation,
# which includes a bias.


# I need to fortify the data AND keep
# trace of the commune code! (Takes ~2 minutes)
library(broom)
spdf_fortified <- tidy(spdf, region = "code")

# Now I can plot this shape easily as described before:
library(ggplot2)
ggplot() +
  geom_polygon(data = spdf_fortified, aes(x = long, y = lat, group = group),
               fill = "white", color = "grey") +
  theme_void() +
  coord_map()

ggplot() +
  geom_polygon(data = spdf_fortified, aes(fill = nb_equip, x = long, y = lat,
                                          group = group)) +
  theme_void() +
  coord_map()

library(viridis)
ggplot() +
  geom_polygon(data = spdf_fortified, aes(fill = POP2005 / 1000000, x = long, y
                                          = lat, group = group), size = 0,
               alpha = 0.9) +
  theme_void() +
  scale_fill_viridis(name = "Population (M)", breaks = c(1, 50, 100, 140),
                     guide = guide_legend(keyheight = unit(3, units = "mm"),
                                          keywidth = unit(12, units = "mm"),
                                          label.position = "bottom",
                                          title.position = "top", nrow = 1)) +
  labs(title = "Africa 2005 Population") +
  ylim(-35, 35) +
  theme(
    text = element_text(color = "#22211d"),
    plot.background = element_rect(fill = "#f5f5f4", color = NA),
    panel.background = element_rect(fill = "#f5f5f4", color = NA),
    legend.background = element_rect(fill = "#f5f5f4", color = NA),
    plot.title = element_text(size = 22, hjust = 0.5, color = "#4e4d47", margin
                              = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
    legend.position = c(0.2, 0.26)
  ) +
  coord_map()
