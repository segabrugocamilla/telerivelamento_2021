# R_code_land_cover.r

library(raster)
library(RStoolbox) # per la classificazione
# install.packages("ggplot2")
library(ggplot2)
# install.packages("gridExtra")
library(gridExtra)

setwd("C:/lab/")

defor1<-brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch= "lin") # plottiamo l'immagine in RGB

# necessari i pacchetti "RStoolbox" e "ggplot"
ggRGB(defor1, r=1, g=2, b=3, stretch= "lin") # creiamo un immagine singola delle 3 bande

defor2<-brick("defor2.jpg")
ggRGB(defor2, r=1, g=2, b=3, stretch= "lin") # facciamo lo stesso procedimento con la seconda immagine

# mettiamo a confronto le due immagini
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# per fare un multiframe delle due immagini con ggplot2 bisogna utilizzare la funzione "grid.arrange"
# necessario installare "gridExtra"

# diamo un nome a ciascuno plot e poi li mettiamo insieme
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch= "lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch= "lin")

grid.arrange(p1,p2, nrow=2)


