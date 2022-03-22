#***********************************
## Use ggplot for making a tile plot
## representing a confusion matrix
#***********************************


ggplot(data =  confusion_matrix,
       mapping = aes(x = Reference, y = Prediction)) +
  geom_tile(aes(fill = Freq), colour = "white") +
  geom_text(aes(label = sprintf("%1.0f", Freq)), vjust = 1) +
  theme_bw() + theme(legend.position = "none")
