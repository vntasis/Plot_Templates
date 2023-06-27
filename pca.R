#************************************************************
## Perform a PCA and plot the principal components
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

dataset <- cbind(metadata$Group, dataset)

dataset %>%
  cbind(pca$x[,1:2]) %>%
  ggplot(aes(PC1, PC2, col = Group, fill = Group)) +
  stat_ellipse(geom = "polygon", col = "black", alpha = 0.5) +
  geom_point(shape = 21, col = "black")


#----------------------------------------------------------
## Perform a PCA, while managing, maintaining and
## evaluating the dataset and the results, all in one tibble
## using tidyverse ,ggfortify and the broom packages.
#----------------------------------------------------------

dataset_pca <- dataset %>%
  nest() %>%
  mutate(pca = map(data, ~ prcomp(.x %>% select(-Group),
                                  center = TRUE, scale = TRUE)),
         pca_aug = map2(pca, data, ~augment(.x, data = .y)))


# Check the variance explained by each PC
var_exp <- dataset_pca %>%
  unnest(pca_aug) %>%
  summarize_at(.vars = vars(contains("edPC", ignore.case = F)),
               .funs = ~ var(.x)) %>%
  pivot_longer(everything(),
               names_to = "pc", values_to = "variance") %>%
  mutate(var_exp = variance/sum(variance),
         cum_var_exp = cumsum(var_exp),
         pc = str_replace(pc, ".fitted", ""),
         PC=factor(str_sub(pc, 3, -1), levels=1:length(pc)))

# Plot variance explained
var_exp %>%
  rename(
    `Variance Explained` = var_exp,
    `Cumulative Variance Explained` = cum_var_exp
  ) %>%
  pivot_longer(c(3,4)) %>%
  ggplot(aes(PC, value, group = name)) +
  geom_point() +
  geom_line() +
  coord_flip() +
  facet_wrap(~name, scales = "free_x") +
  theme_bw() +
  ylab("") +
  scale_x_discrete(labels=seq(1,nrow(var_exp),2) %>%
                   paste0("_") %>% str_split("_") %>% unlist)



#-----------------------------------
## Plot scatter plots for all the
## combinations of the first 5 PCs
## with ggplot and facets
#-----------------------------------
library(grid)
library(gtable)

# Reshape pca output into long tibble
# and take the 5 first principal components
pca_long <-
  pca$x %>%
  as.data.frame %>%
  rownames_to_column("SampleID") %>%
  pivot_longer(-SampleID) %>%
  filter(name %in% paste0("PC", 1:5)) %>%
  left_join(metadata)

# Form tibble with all the PC combinations
pcB <-
  pca_long %>%
  rename(pcB=name, PcompB=value) %>%
  select(-Group)

pca_long %<>%
  rename(pcA=name, PcompA=value) %>%
  left_join(pcB)

rm(pcB)

# Make faceted scatter plots
pca_long %>%
  ggplot(aes(PcompA, PcompB, col = Group, fill = Group)) +
  stat_ellipse(geom = "polygon", alpha = 0.5) +
  geom_point(shape = 21, col = "black") +
  facet_grid(cols = vars(pcA), rows = vars(pcB))
