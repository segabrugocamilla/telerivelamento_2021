# R_code_vegetation_indices.r


# install.packages("rasterdiv")
# per l'indice NDVI del pianeta


library(raster) # require(raster)
library(RStoolbox) # per il calcolo degli indici di vegetazione
library(rasterVis)

setwd("C:/lab/")

defor1<-brick("defor1.jpg") #immagine della foresta amazzonica al tempo 1
defor2<-brick("defor2.jpg") #immagine della foresta amozzonica al tempo 2

# b1= NIR, b2= red, b3= green

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin") # vediamo le due immagine sulla stessa colonna, si nota la grande diminuzione di vegetazione della foresta amazzonica

# calcoliamo il primo indice di vegetazione (NIR-RED)

# andiamo a vedere il nome delle bande aprendo tutte le informazioni del file
defor1 
# names: defor1_.1, defor1_.2, defor1_.3 
# defor1_.1 = NIR
# defor1_.2 = red
# defor1_.3 = green

#facciamo il difference vegetation index
dvi1 <- defor1$defor1.1-defor1$defor1.2 # per ogni pixel prendiamo il valore nel NIR e sottraiamo il valore nel RED, si crea una mappa composta dalla differenza dei pixel = DVI
plot(dvi1)

#creiaom una palette per vedere i risultati
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifichiamo lo schema dei colori in modo che si veda bene la vegetazione in rosso

plot(dvi1, col=cl, main="DVI at time 1") # in questo modo visualizziamo il DVI che abbiamo appena calcolato e lo chiamiamo "DVI at time 1" perchè ci mostra l'indice di vegetazione della prima immagine della foresta amazzonica


# calcoliamo l'indice di vegetazione per la seconda immagine
dvi2 <- defor2$defor2.1-defor2$defor2.2
plot(dvi2)
plot(dvi2, col=cl, main="DVI at time 2") # è ben visibile in giallo la parte in cui non è più presente vegetazione

# mettiamo le due immagini a confronto
par (mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

# Qual'è la differenza nella stessa zona tra questi due tempi? facciamo la differenza tra i DVI delle due situazioni
difdvi <- dvi1 - dvi2 #facciamo la differenza per ogni pixel, anche se hanno estensione diversa viene calcolata la differenza dove è presente l'intersezione.

plot(difdvi)

cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)


# ndvi: facciamo la standardizzazione sulla somma dell'indice di vegetazione
# NDVI= (NIR-RED) / (NIR+RED)
#utilizziamo la ndvi perchè possiamo trovare immagini a 8 o 16 bit e se dobbiamo utilizzarle insieme i valori non corrisponderanno, per questo il valore viene normalizzato
#i valori minimi saranno nel caso di 8 bit 0-255=-1
#i valori massimi saranno 0+255=+1
#quindi i valori andranno da -1 a +1


ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
# si potrebbe anche fare ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)


plot(ndvi1)

plot(ndvi1, col=cl)

ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)

# Rstoolbox: spectralIndices
#con questa funzione inserendo l'immagine possiamo calcoalre molti indici spettrali che possono esserci utili

vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot (vi1, col=cl)

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot (vi2, col=cl)


#vediamo la differenza tra gli indici di vegetazione delle due immagini normalizzati

difndvi <- ndvi1 - ndvi2
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)












