# R_code_variability.r
# Analizziamo pattern spaziali tramite l’uso di indici del paesaggio nell’area del ghiacciao del Similaun

library(raster)
library(RStoolbox)

setwd("C:/lab/")

brick("sentinel-png") # portiamo dentro R l'immagine che abbiamo scaricato del ghiacciao del Similaun


