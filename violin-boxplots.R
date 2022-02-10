# Basic violin - box Plot 

ggplot(data, aes(x, y, colour = x)) +
  geom_violin(trim=FALSE, fill='grey') +
  geom_boxplot(width=0.05, fill='grey') +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  scale_color_nejm()


# Boxplots combined with facet_wrap

dt %>%
  ggplot(aes(x, y, colour = x)) +
  geom_boxplot(fill = "grey") +
  facet_wrap(~parameter, ncol = 12) +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  scale_color_futurama()


# Draw Boxplots without outliers
# filtering function - turns outliers into NAs to be removed
filter_lims <- function(x){
  l <- boxplot.stats(x)$stats[1]
  u <- boxplot.stats(x)$stats[5]

  for (i in 1:length(x)){
    x[i] <- ifelse(x[i]>l & x[i]<u, x[i], NA)
  }
  return(x)
}

dt %>%
  group_by(parameter, x) %>%
  mutate(y = filter_lims(y)) %>%
  ggplot(aes(x, y, colour = x)) +
  # remove NAs, and set the whisker length to all included points
  geom_boxplot(fill = "grey", na.rm = TRUE, coef = 5) +
  facet_wrap(~parameter, ncol = 12) +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  scale_color_brewer(type = 'qual', palette='Dark2')


# Violin - box Plot accompanied by a statistical test

ggplot(dt, aes(x, y, colour = x)) +
  geom_violin(trim=FALSE, fill='grey') +
  geom_boxplot(width=0.1, fill = "grey") +
  geom_hline(yintercept = mean(dt$y), linetype = 2) +
  theme(axis.text.x = element_text(angle=65, vjust=0.7, hjust = 0.7)) +
  scale_color_manual(values = colorRampPalette(pal_uchicago()(9))(10)) +
  stat_compare_means(label = "p.signif", method = "wilcox.test",
                     ref.group = ".all.", label.y = 1.15)
