# il mio primo codice in R per il corso di telerilevamento
setwd("C:/lab/")

# install.packages("raster")
library(raster)

p224r63_2011<-brick("p224r63_2011_masked.grd")
# p224r63_2011

plot(p224r63_2011) #visualizzare tutte le bande con valori riflettanza

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: NIR
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

### DAY 2
#colorRampPalette per cambiare i colori
cl<-colorRampPalette(c("black","grey","light gray"))(100) #c è il vettore argomento, 100 sono i livelli del colore

plot(p224r63_2011, col=cl)

# cambiamo colore a piacere
cl<-colorRampPalette(c("green","purple","orange","pink"))(200)

### DAY 3
plot(p224r63_2011$B1_sre) 

# plot della banda uno con la scala di colori che voglio

cl<-colorRampPalette(c("green","purple","orange","pink"))(200)
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

dev.off() #per chiudere i grafici

# 1 riga, 2 colonne
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# 2 row, 1 columns
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# plot the first four bands of Landsat
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#quadrante di bande
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

par(mfrow=c(2,2)) #faccio il plot di un quadrante 2x2 delle bande B1, B2, B3, B4 cambiano i colori

clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)
