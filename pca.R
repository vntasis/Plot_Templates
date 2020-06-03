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
  summarize_at(.vars = vars(contains("edPC", ignore.case = F)), .funs = funs(var)) %>%
  gather(key = pc, value = variance) %>%
  mutate(var_exp = variance/sum(variance),
         cum_var_exp = cumsum(var_exp),
         pc = str_replace(pc, ".fitted", ""))

var_exp %>%
  mutate(PC=str_sub(pc, 3, -1) %>% as.integer) %>%
  rename(
    `Variance Explained` = var_exp,
    `Cumulative Variance Explained` = cum_var_exp
  ) %>%
  gather(key = key, value = value, `Variance Explained`:`Cumulative Variance Explained`) %>%
  ggplot(aes(PC, value, group = key)) +
  geom_point() +
  geom_line() +
  coord_flip() +
  facet_wrap(~key, scales = "free_y") +
  theme_bw() +
  labs(y = "Variance",
       title = "Variance explained by each principal component")


dataset_pca %>%
  mutate(
    pca_graph = map2(
      .x = pca,
      .y = data,
      ~ autoplot(.x,
                 data = .y,
                 colour="Group") +
        labs(x = "Principal Component 1",
             y = "Principal Component 2",
             title = "First two principal components of PCA on x dataset")
    )
