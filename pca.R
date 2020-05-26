#************************************************************
## Perform a PCA and plot the first two principal components
## in a scatter plot
#************************************************************

#--------------------------------------
## Perform a PCA and make a quick plot
#--------------------------------------

pca <- prcomp(x = dataset, center = T, scale. = T)
summary(pca)
head(pca)
biplot(pca, scale = 0)

#---------------------------------------------------------
## Plot the resutls with ggplot in a scatterplot
## overlayed with ellipses highlighting different groups
## (or any metadata)
#---------------------------------------------------------

dataset <- cbind(metadata$Groups, dataset)

dataset %>%
  cbind(pca$x[,1:2]) %>%
  ggplot(aes(PC1, PC2, col = Groups, fill = Groups)) +
  stat_ellipse(geom = "polygon", col = "black", alpha = 0.5) +
  geom_point(shape = 21, col = "black")

