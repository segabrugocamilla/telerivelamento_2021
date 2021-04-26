# Time series analysis
# Greenland increase of temperature
# Data and code from Emanuela Cosma

# install.packages ("raster")
library(raster)

setwd("C:/lab/greenland")

lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)

lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)
