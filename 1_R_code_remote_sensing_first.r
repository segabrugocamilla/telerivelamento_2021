# il mio primo codice in R per il corso di telerilevamento

#install.packages("sp") #per la gestione dei dati all'interno del software
#install.packages("raster")
# install.packages("RStoolbox")


# per prima cosa carichiamo e richiamiamo le librerie
library(raster)
library(sp) 
library(RStoolbox)

setwd("C:/lab/") # settiamo la set working director

#importiamo un file precedentemente scaricato attraverso la funzione brick e lo rinominimo
p224r63_2011<-brick("p224r63_2011_masked.grd") # brick è la funzione per creare un raster multistrato: importa un intero set di dati (nel nostro caso bande dai satelliti) creando un RasterBrick. Asocciamo il nome "p224r63_2011"

# p224r63_2011 : inserendo il nome su R visualizziamo le informazioni contenute nell'immagine
p224r63_2011

plot(p224r63_2011) # utilizziamo la funzione plot per visualizzare tutte le bande con i valori di riflettanza

#Avremo come risultato un plot con questi colori (BANDE LANDSAT):
# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: NIR (infrarosso vicino)
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

### DAY 2
#colorRampPalette per cambiare i colori
cl<-colorRampPalette(c("black","grey","light gray"))(100) # c è il vettore argomento, 100 sono i livelli del colore

plot(p224r63_2011, col=cl) # plottiamo con i nuovi colori

# cambiamo colore a piacere
cl<-colorRampPalette(c("green","purple","orange","pink"))(200)

### DAY 3
# utilizziamo il simbolo "$" per legale una banda all'immagine satellitare - scelgo il livello del multistrato che ci interessa
plot(p224r63_2011$B1_sre)

# plot della banda uno con la scala di colori che vogliamo

cl<-colorRampPalette(c("green","purple","orange","pink"))(200)
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

dev.off() #per chiudere i grafici aperti

# par funzione generica, serve per fare un settaggio dei parametri grafici di un grafico che si vuole creare 
# multiframe - plot di due o più bande all'interno di uno stesso grafico
# multiframe : 1 riga, 2 colonne
par(mfrow=c(1,2)) #si mette la c dvanti ai due blocchi perchè è un vettore, se ci sono più blocchi stiamo avendo a che fare con un vettore. come già visto per i colori nella funzione colorRampPalette
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# se si vogliono inserire prima le righe e poi le colonne si utilizza: par(mfrow..), se si desidera mettere prima le colonne e poi le righe invece si utilizza: par(mfcol...)

# 2 righe, 1 colonne
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# plot delle prime quattro bande di Landsat
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

par(mfrow=c(2,2)) #faccio il plot di un quadrante 2x2 delle bande B1, B2, B3, B4 e poi cambio i colori

clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)

# questi comandi servono per predisporre in maniera riassuntiva le immagini, unendo e colorando le diverse bande


### DAY 4
# Visualizing data by RGB plotting

library(raster)

setwd("C:/lab/")

p224r63_2011<-brick("p224r63_2011_masked.grd")

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: NIR
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

# vogliamo osservare l'immagine con lo schema dei colori RGB (red, green e blu) associati alle prime 3 bande, in questo modo sarà possibile vedere l'immagine con i colori naturali
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #la funzione stretch lineare serve per visuaizzare meglio i colori, affinchè non si crei uno schiacciamento verso un valore

#al posto di r=3, g=2, b=1 si possono mettere direttamente i numeri: 1,2,3 

#montiamo queste quattro bande in un multiframe 2x2
pdf("mio_primo_pdf_in_R.pdf") # salviamo il pdf dell'immagine
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #così vedo bene la vegetazione in verde
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") # chiamata anche funzione logistica, aumenta lo strech e la possibilità di vedere nuove componenti della foresta (es. umidità)

#par dell'immagine con colori naturali, colori con infrarosso sul verde, colori con infrarosso sul verde con funzione hist dello strech
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") 
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

### DAY 5
# Multitemporal set
# importiamo un'immagine uguale a quella usata fino ad ora del 2011, ma presa nel 1988
p224r63_1988<-brick("p224r63_1988_masked.grd") #brick serve per importare un intero set di bande creando l'oggeto RasterBrick
p224r63_1988 

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: NIR
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

plot(p224r63_1988) #vengono plottate le singole bande non in RGB
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin") #mettiamo la banda B3 sul rosso, la banda B2 sul verde e B1 sul blu

plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin") #plot con colori naturali
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") #in questo modo si vedrà in rosso la banda dell'infrarosso, tutto quello che è rosso è la componente della foresta perchè la vegetazione riflette nel NIR

#facciamo un plot delle immagini del 1988 e 2011 per confrontare le diverse distribuzioni della foresta:
par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

# creiamo il pdf dell'analisi multitemporale
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") # è visibile un passaggio graduale da un ambiente all'altro
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") # nel 2011 è visibile una soglia netta del passaggio tra foresta pluviale e l'impatto umano con la coltivazione
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist") #molto visibili le variazioni dovute al rumore sull'immagine
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist") 
dev.off()





