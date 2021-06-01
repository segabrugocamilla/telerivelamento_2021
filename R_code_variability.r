# R_code_variability.r
# Analizziamo pattern spaziali tramite l’uso di indici del paesaggio nell’area del ghiacciao del Similaun

library(raster)
library(RStoolbox)

setwd("C:/lab/")

sent <- brick("sentinel.png") # portiamo dentro R l'immagine che abbiamo scaricato del ghiacciao del Similaun

plotRGB(sent, stretch="lin") # non dobbiamo specificare in che colore mettere le bande perchè sono già r=1, g=2, b=3 dove NIR 1, RED 2, GREEN 3

plotRGB(sent, r=2, g=1, b=3, stretch="lin") # viene mostrata la componente rocciosa in viola, la vegetazione in verde e acqua in nero perchè assorbe il NIR

# calcoliamo l'indice NDVI e calcoliamo la varibilità dell'immagine
sent # per vedere come si chiamano le bande
# rinominiamo e leghiamo le bande all'immagine
nir <- sent$sentinel.1
red <- sent$sentinel.2

ndvi <- (nir-red)/ (nir+red)
plot(ndvi) # dove è presente il bianco non c'è vegetazione, marroncino rappresenta la roccia, giallo e verde chiaro è la vegetazione 

cl<- clorRampPalette(c('black', 'white', 'red', 'magenta', 'green'))(100)
plot(ndvi, col=cl)

# calcoliamo la deviazione standard di questa immagine
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd) # w= window
plot(ndvisd3)

clsd <- colorRampPalette(c('blue', 'green', 'pink', 'magenta', 'orange', 'brown', 'red', 'yellow'))(100)
plot(ndvisd3, col=clsd) # la deviazione standard è più bassa dove è presente la roccia nuda ed aumenta in corrispondenza del passaggio alla vegetazione per poi aumentare di nuovo nelle parti vegetate

# calcoliamo la media




                                 
