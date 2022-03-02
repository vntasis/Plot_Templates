# Calculate tpm correlation between the different samples of a dataset,
# apply a hierarchical clustering using the correlation as distance metric,
# and plot correlation with a heatmap accompanied by a dendrogram.

# auxiliary functions

get_upper_tri <- function(cormat){
  cormat[lower.tri(cormat)]<- NA
  return(cormat)
}

reorder_cormat <- function(cormat){
  # Use correlation between variables as distance
  dd <- as.dist((1-cormat)/2)
  hc <- hclust(dd, method = "ward.D2")
  cormat <-cormat[hc$order, hc$order]
  cormat
}

# calculate correlation

tpm_cor <-
  x %>%
  as.matrix() %>%
  cor(method = "spearman")  %>%
  reorder_cormat %>%
  get_upper_tri %>%
  melt


# plot correation

p3 <-
  tpm_cor %>%
  ggplot( aes(Var1, Var2, fill = Correlation)) +
  geom_tile(colour = "white", size = 0.3) +
  scale_fill_gradient2(low = "lightblue", high = "firebrick", mid = "white",
                      midpoint = 0, limit = c(-1,1), space = "Lab",
                      name="Spearman\nCorrelation") +
  theme_bw() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.x = element_text(angle=65, vjust=0.6)
  )



p4 <-
  x %>%
  as.matrix() %>%
  cor(method = "spearman")  %>%
  (function(i)as.dist((1-i)/2)) %>%
  hclust(method = "ward.D2") %>%
  ggdendro::ggdendrogram(rotate = TRUE) +
  scale_y_reverse() +
  theme(axis.text.y=element_blank(),
        axis.text.x = element_blank())

grid::grid.newpage()
print(p4, vp = grid::viewport(x = 0.11, y = 0.53, width = 0.20, height = 1.0))
print((p3 + scale_fill_material("orange", name="Spearman\nCorrelation")),
      vp = grid::viewport(x = 0.60, y = 0.5, width = 0.8, height = 1.0))



#----------------------------------------------------------
## Example of correlation heatmap using tidyHeatmap package
#----------------------------------------------------------

x %>%
  as.matrix() %>%
  cor(method = "spearman")  %>%
  as.data.frame %>%
  rownames_to_column('Sample1') %>%
  pivot_longer(!Sample1) %>%
  rename(Sample2=name) %>%
  left_join(metadata %>%
            select(SampleID, Group),
            c("Sample2" = "SampleID")) %>%
  heatmap(Sample1, Sample2, value,
  rect_gp = grid::gpar(col = "#161616", lwd = 0.5),
  .scale = "none",
  clustering_method_rows = "ward.D2",
  clustering_method_columns = "ward.D2") %>%
  add_tile(Group)
