# R_code_classification.r
# Processo che accorpa pixel con valori simili e rappresenta una classe. 

library(raster)
library(RStoolbox)

setwd("C:/lab/")

so<-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") # abbiamo portato all'interno di R l'immagine chiamoandola "so"

# visualizziamo i livelli RGB
plotRGB(so, 1,2,3, stretch="lin")

# Classificazione non supervisionata, senza impatto dell'utente i pixel vengono associati per il valore in RGB
soc <- unsuperClass(so, nClasses=3) # ha creato in uscita il modello e la mappa
plot(soc$map) # facciamo plot dell'immagine classificata e visto che vogliamo vedere la mappa la leghiamo a quest'ultima

# Classificazione non supervisionata con 20 classi
sot <- unsuperClass(so, nClasses=20)
plot(sot$map)

# Immagine scaricata da:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("sun.png")

# Classificazione non supervisionata
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map, col=cl)

cl <- colorRampPalette(c('yellow','purple','pink'))(100)
plot(sunc$map, col=cl)

# Gran Canyon 
# https://landsat.visibleearth.nasa.gov/view.php?id=80948

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")

plotRGB(gc, r=1, g=2, b=3, stretch="lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)

gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)
