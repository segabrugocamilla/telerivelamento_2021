# il mio primo codice in R per il corso di telerilevamento
setwd("C:/lab/")

# install.packages("raster")
library(raster)

p224r63_2011<-brick("p224r63_2011_masked.grd")
# p224r63_2011

plot(p224r63_2011) #visualizzare tutte le bande con valori riflettanza

# B1: blu
# B2: verde
# B3: rosso
# B4: NIR
# B5: infrarosso intermedio
# B6: infrarosso termico

#colorRampPalette per cambiare i colori
cl<-colorRampPalette(c("black","grey","light gray"))(100) #c è il vettore argomento, 100 sono i livelli del colore

plot(p224r63_2011, col=cl)

# cambiamo colore a piacere
cl<-colorRampPalette(c("green","purple","orange","pink"))(200)
