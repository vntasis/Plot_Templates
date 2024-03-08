#=============================================================================
## Template that uses base R to bin a variable in a custom manner and plot the
## frequency of the bins in a barplot (histogram). This template demonstrates
## adjusting the following plot features using base R:
## - Binning
## - Margin size
## - Line thickness
## - Plot colors
## - Axis title position, font size and content
## - Axis labels position, orientation, values, size
## - Text labels
## This example plots a variable whose values encode genomic distances for
## enhancer - gene pairs
#=============================================================================

# Adjust margins and line width
opar <- par(lwd = 3.5, mar = c(9, 7, 9, 2) + 0.1)

# distance is the variable of interest
distance <- abs(distance)

# Binning and frequency calculation
distance_binned <-
  .bincode(distance, c(7000, 10000, 50000,
                       100000, 200000, 500000,
                       1e+6, 10e+6, 40e+6), include.lowest = TRUE)
t <- table(distance_binned)

# Barplot (custom histogram) generation
x <- barplot(t,
  main = "",
  col = "#a6bddb", border = "black",
  cex.axis = 2, las = 2, xaxt = "n", ylim = c(0, 6000)
)
# Axes titles
title(ylab = "Frequency (Number of Enhancer - Gene Pairs)",
      line = 5.5, cex.lab = 2)
title(xlab = "Enhancer - TSS distance", line = 8, cex.lab = 2)
# X axis labels adjustment
text(
  x = x + 0.3, y = par("usr")[3] - 0.45,
  labels = c("7 - 10 kb", "10 - 50 kb", "50 - 100 kb",
             "100 - 200 kb", "200 - 500 kb",
             "0.5 - 1 Mb", "1 - 10 Mb", "10 - 40 Mb"),
  xpd = NA, srt = 35, cex = 2, adj = 1.2
)
# Text label for each bar
text(x = x, y = t, labels = t, pos = 3, xpd = NA, cex = 2)
