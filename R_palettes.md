# Personal preferences regarding R palettes in combination with ggplot2


### Required Packages
- [ggshi](https://nanx.me/ggsci/articles/ggsci.html "ggshi's vignette")
- [wesanderson](https://github.com/karthik/wesanderson "wesanderson's github repository")
- [RColorBrewer](http://colorbrewer2.org "colorbrewer's color guide")
- [viridis](https://cran.csiro.au/web/packages/viridis/viridis.pdf "package documentation")


#### Collection of most color palettes in a single R package
- [paletteer](https://github.com/EmilHvitfeldt/paletteer)


### Preferred palettes
#### ggshi
- Futurama
- NEJM
- JAMA
- UChicago

#### wesanderson
- Darjeeling1
- FantasticFox1
- Zissou1

#### RColorBrewer
- Dark2
- Set1
- Paired

#### virdis
- virdis
- inerno


### Useful functions
- `scale_color_gradient()`, `scale_fill_gradient()` for sequential gradients between two colors
- `scale_color_gradient2()`, `scale_fill_gradient2()` for diverging gradients
- `scale_color_gradientn()`, `scale_fill_gradientn()` for gradient between n colors
- `scale_fill_grey()`, `scale_colour_grey()` are always a classic
- `scale_color_viridis()` and `scale_fill_viridis()` for virdis color scales
- `scale_colour_brewer` and `scale_fill_brewer` for [brewer scales](https://ggplot2.tidyverse.org/reference/scale_brewer.html)
- `colorRampPalette()` can be utilized to produce a larger number of colors than those available in a palette

   which subsequently can be fed to `scale_color_manual()` or `scale_fill_manual()`
   
   e.g. `scale_color_manual(values = colorRampPalette(RColorBrewer::brewer.pal(8, "Dark2"))(16))`


### Useful pages
- [TOP R COLOR PALETTES TO KNOW FOR GREAT DATA VISUALIZATION](https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/)
- [ggplot2 colors : How to change colors automatically and manually?](http://www.sthda.com/english/wiki/ggplot2-colors-how-to-change-colors-automatically-and-manually)
- [ggplot colors - best tricks](https://www.datanovia.com/en/blog/ggplot-colors-best-tricks-you-will-love/)


### Color-blind friendly palettes
- `colorblind_pal()`,`scale_colour_colorblind()`, `scale_color_colorblind()`, `scale_fill_colorblind` functions from [ggthemes](https://rdrr.io/cran/ggthemes/man/colorblind.html) package
- Use display.brewer.all(colorblindFriendly = TRUE) to see the colorblind-friendly palettes of [RColorBrewer](http://colorbrewer2.org "colorbrewer's color guide")
- Both virdis and ggsci have colorblind-friendly options.

#### For more details check thes pages
- [Color Universal Design](https://jfly.uni-koeln.de/color/)
- [Tips for designing colorblind-friendly visualizations](https://www.tableau.com/about/blog/2016/4/examining-data-viz-rules-dont-use-red-green-together-53463)
- [Colormaps in python (virdis related)](https://bids.github.io/colormap/)
