# Plotting results of Functional analysis 
# (i.e. enrichment anaysis of a set of genes for biological pathways or other ontologies) 
# with a barplot - package used: ggplot2

df %>%
  ggplot(aes(y = , x = )) +
  geom_bar(position="dodge", stat="identity") +
  geom_col(aes(fill = p.value)) + 
  scale_fill_gradient2(low = "firebrick",
                       mid = "azure4",
                       high = "blue", 
                       midpoint = median(df$p.value)) + 
  coord_flip() +
  ggtitle("Functional Analysis for ...")


# Plotting results of a GSEA-like analysis 
# (i.e. gene set - module enrichment anaysis) 
# with a barplot - package used: ggplot2

modules %>%
  ggplot(aes(x = Module, y = Number_of_genes, fill = Deregulation)) +
  geom_bar(width = 1, stat = "identity") +
  scale_fill_manual(values = c("blue", "red", "grey")) +
  coord_flip()