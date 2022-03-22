#*************************************
## Displaying tables as grid graphics*
#*************************************

library(grid)
library(gridExtra)
library(gtable)

# Default table
grid.table(my_table)


# Custom table - Add borders
g <- tableGrob(my_table, rows = NULL)
g <-
  gtable_add_grob(g, grobs = rectGrob(gp = gpar(fill = NA, lwd = 2)),
                  t = 2, b = nrow(g), l = 1, r = ncol(g))
g <-
  gtable_add_grob(g, grobs = rectGrob(gp = gpar(fill = NA, lwd = 2)),
                  t = 1, l = 1, r = ncol(g))
grid.draw(g)


# Custom table - Dashed line as separators and minimal theme
g <- tableGrob(my_table,
               rows = NULL,
               theme = ttheme_minimal())
separators <-
  replicate(ncol(g) - 2,
            segmentsGrob(x1 = unit(0, "npc"),
                         gp=gpar(lty=2)),
            simplify=FALSE)

g <- gtable_add_grob(g, grobs = separators,
                     t = 2, b = nrow(g),
                     l = seq_len(ncol(g)-2)+2)
grid.draw(g)
