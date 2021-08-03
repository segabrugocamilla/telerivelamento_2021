# R code complete - Telerilevamento Geo-Ecologico


#--------------------------------------------


# Summary:

# 1. Remote Sensiting - first code
# 2. R code time series
# 3. R code copernicus data
# 4. R code knitr
# 5. R code multivariate analysis
# 6. R code classification
# 7. R code ggplot2
# 8. R code vegetation indices
# 9. R code land cover
# 10. R code variability
# 11. R code spectral signatures


#--------------------------------------------


# 1. Remote sensiting first code

# il mio primo codice in R per il corso di telerilevamento
# per prima cosa carichiamo e richiamiamo le librerie
# install.packages("raster")
library(raster)
library(sp) # per la gestione dei dati all'internod el software
# install.packages("RStoolbox")
library(RStoolbox)


setwd("C:/lab/") # settiamo la set working director

p224r63_2011<-brick("p224r63_2011_masked.grd") # brick è la funzione per creare un raster multistrato: importa un intero set di dati (nel nostro caso bande dai satelliti) creando un RasterBrick. Asocciamo il nome "p224r63_2011"
# p224r63_2011

plot(p224r63_2011) # utilizziamo la funzione plot per visualizzare tutte le bande con i valori di riflettanza

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

dev.off() #per chiudere i grafici

# par funzione generica, serve per fare un settaggio dei parametri grafici di un grafico che si vuole creare 
# multiframe - plot di diverse bande all'interno di uno stesso grafico
# multiframe : 1 riga, 2 colonne
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

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

# abbiamo imparato come predisporre in maniera riassuntiva le immagini, come plottarle

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

#per osservare l'immagine con le componenti dei colori RGB associati alle prime 3 bande
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #la funzione stretch lineare serve per visuaizzare meglio i colori

#vogliamo vedere l'infrarosso vicino, quindi facciamo slittare di uno le bande
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#cambio la componente su cui monto la banda dell'infrarosso vicino per visualizzare diverse proprietà della vegetazione nell'immagine
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#montiamo queste quattro bande in un multiframe 2x2
pdf("mio_primo_pdf_in_R.pdf") # salviamo il pdf dell'immagine
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #così vedo bene la vegetazione in verde
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") # chiamata anche funzione logistica, aumenta lo strech e la possibilità di quello che vediamo 

#par colori naturali, colori con infrarosso sul verde, colori con infrarosso sul verde con funzione hist dello strech
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") 
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

### DAY 5
# Multitemporal set
# 1988 image
p224r63_1988<-brick("p224r63_1988_masked.grd") #brick serve per importare un intero set di bande creando l'oggeto RasterBrick
p224r63_1988 

plot(p224r63_1988)
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin") #mettiamo la banda B3 sul rosso, la banda B2 sul verde e B1 sul blu

plot(p224r63_1988) #vengono plottate le singole bande non in RGB
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin") #plot con colori naturali
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") #in questo modo si vedrà in rosso la banda dell'infrarosso, tutto quello che è rosso è la componente della foresta

#facciamo un plot delle immagini del 1988 e 2011 per confrontare le diverse distribuzioni della foresta:
par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

# creiamo il pdf dell'analisi multitemporale
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist") #molto visibili le variazioni dovute al rumore sull'immagine. 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist") #nel 2011 è visibile una soglia netta del passaggio tra foresta pluviale e l'impatto umano con la coltivazione
dev.off()


#--------------------------------------------


# 2. -R code time series

# Time series analysis
# Greenland increase of temperature
# Data and code from Emanuela Cosma

# install.packages ("raster")
library(raster)
# install.packages("rasterVis")
library(rasterVis)

setwd("C:/lab/greenland")

# analizziamo dati sulla temperatura e sullo strato del ghiaccio della Groellandia

# STACK -> funzione utilizzata per trasformare dati disponibili come colonne separate in un dataframe o lista avente una singola colonna che può essere utilizzato nello studio dei modelli di variaanza o altri modelli lineari
# utilizziamo la funzioen raster presente nel pacchetto raster per creare un oggetto RasterLayer

lst_2000 <- raster("lst_2000.tif") 
plot(lst_2000)

lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)

lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

# utilizziamo la funzione par per creare un multiframe
par(mfrow=c(2,2))
plot(lst_2005)
plot(lst_2000)
plot(lst_2010)
plot(lst_2015)

#we wont to list the files in a Directory/Folder
#list.files
rlist<-list.files(pattern="lst") #abbiamo fatto la lista dei files che contenevano "lst" e lo associamo all'oggetto "rlist"
rlist

#lapply a function over a list-like or vector-like object
#lapply(X, FUN, ...)
import <- lapply(rlist,raster) #abbiamo applicato la funzione "raster" alla lista "rlist" precedentemente creata e l'abbiamo associato all'oggetto "import"
import

TGr <- stack(import) #la funzione stack crea un unico file grande che comprende tutti i dati che associamo all'oggetto "TGr"
plot(TGr)

#creiamo un file composto dalle temperature nei vari anni su un'unica immagine
plotRGB(TGr, 1, 2, 3, stretch="Lin") # dall'abbondanza di blu si nota che ci sono valori più alti del 2010
plotRGB(TGr, 2, 3, 4, stretch="Lin")

library(rasterVis) #che abbiamo installato per supportare la funzione "levelplot"

levevlplot(TGr) # mostra le 4 immagini satellitari
levelplot(TGr$lst_2000) # il grafico, smostra l'andatura media della temperatura per colonna, lo stesso a destra per riga

cl <- colorRampPalette(c("pink","purple","orange","light blue"))(100) #cambiamo la colorRampPalette, possiamo farlo perchè plottiamo delle immagini singole e non un'immagine satellitare in RGB
levelplot(TGr, col.regions=cl)

levelplot(TGr,col.regions=cl,names.attr=c("July 2000","July 2005","July 2010","July 2015")) #rinominiamo gli attributi (le 4 immagini nel grafico)


# usiamo i dati Melt

meltlist<-list.files(pattern="melt") # facciamo una lista con tutti i dati melt
importmelt <- lapply(meltlist,raster) # applichiamo la funzione "lapply" alla lista
melt <- stack(importmelt) # creiamo un "raster stack"
melt 

levelplot(melt) #otteniamo il grafico con i valori dello sciogliemto dei ghiacci dal 1979 al 2007
          
# facciamo la sottrazione tra il primo dato e il secondo e creiamo un file con la differenza
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt

clb <- colorRampPalette(c("blue","white","red"))(100) #creiamo la colorRampPalette
plot(melt_amount, col=clb) # viene così evedenziato dove c'è stato una grande diminuizione del ghiaccio dal 1979 al 2007
# abbiamo visto come visualizzare un set di dati numerosi e anche le loro differenze


#--------------------------------------------


# 3. R code copernicus data

#R_code_copernicus.r
#Visualizzazione dei dati corpernicus
#abbiamo bisogno della libreria raster e ncdf4 per leggere questo formato di dati

library(raster)
# install.packages("ncdf4")
library(ncdf4)

setwd("C:/lab/")
library(raster)

FAPAR <- raster("c_gls_FAPAR-RT0_202006300000_GLOBE_PROBAV_V2.0.1.nc") # importiano i dati in R e rinominiamo
FAPAR

#facciamo il primo plot di questa immagine, non montiamo sulle bande RGB perchè abbiamo solo uno strato e possiamo decidere la scala di colori da usare
cl <- colorRampPalette(c('pink','red','orange','yellow'))(100)
plot(FAPAR,col=cl)

#questo dato si può ricampionare per renderlo più gestibile, prendiamo un pixel più grande e ad esempio estraiamo la media di quelli più piccoli contenuti. es. con fact=10 diminuisco di 10 volte
FAPARes <- aggregate(FAPAR, fact=100) #ricampionamento bilineare (10000 volte il dato originale)
plot(FAPARes, col=cl)


#--------------------------------------------


# 4. R code knitr

# R_code_knitr.r
# install.packages("knitr")
library(knitr)

setwd("C:/lab/") #settiamo la working directory, da cui prenderemo il nostro codice originale per fare il "report"

# usiamo un gestore di testo dove copiare tutto il codice che vogliamo importare

getwd() # per controllare la cartella di lavoro

# importiamo dalla cartella selezionata il file contenente il codice per creare un pdf unico
#utiliziammo la funzione stitch per andare a prendere il codice, per prima cosa metteremo il nome del file di testo che abbiamo creato
stitch("R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr")) 

# in questo caso avendo windows si è generato un file.tex che va trasformato in pdf -> usiamo overleaf


#--------------------------------------------


# 5. R code multivariate analysis

# R_code_multivariate_analysis

library(raster)
library(RStoolbox)

setwd("C:/lab/")


# importiamo dentro R con la funzione brick la nostra immagine .grd

p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011


# plottiamo l'immagine e vediamo che sono presenti 7 bande
plot(p224r63_2011) 


#Confrontiamo la banda 1 con la banda 2 attraverso il plot
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2) # verranno di colore rosso, pch per la forma del sibolo e cex=2 per aumentare la dimensione

pairs(p224r63_2011) #mette in correlazione a due a due tutte le variabili di un certo dataset, in questo caso le bande


#aggregate cells: ricampionamento. Aggreghiamo i pixel utilizzando la media per rendere il dato più leggero per poi fare con più facilità la PCA
p224r63_2011res <- aggregate(p224r63_2011, fact=10) #lineramente lo aumentiamo di 10


#confrontiamo le due immagini, la seconda sarà molto meno definita
par(mfrow=c(2,1)) 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")


# PCA: principal componing analysis
# prenidmao un asse nella variabilità maggiore e una a quella minore
p224r63_2011_pca <-rasterPCA(p224r63_2011res)


# otteniamo un sommario del nostro modello
summary(p224r63_2011_pca$model)
p224r63_2011_pca # per legare i due componenti: modello e mappa

plot(p224r63_2011_pca$map) #per osservare graficamente la situazione del modello, lego l'oggetto alla mappa

plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch="lin") # facciamo un plot RGB con le prime tre componenti

str(p224r63_2011_pca) # per avere informazioni aggiuntive sul file


#--------------------------------------------


# 6. R code classification

# R_code_classification.r
# Processo che accorpa i pixel con valori simili e rappresenta una classe. 

library(raster)
library(RStoolbox)

setwd("C:/lab/")

# scarichiamo i dati dei diversi livelli energetici del sole dalla pagina di Virtuale e le mettiamo nella cartella lab.
so<-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") # abbiamo portato all'interno di R l'immagine chiamoandola "so"
so # mostra i livelli energetici da 0 a 255 in bit

# visualizziamo i livelli RGB
plotRGB(so, 1,2,3, stretch="lin")

# Classificazione non supervisionata, senza impatto dell'utente i pixel vengono associati per il valore in RGB
soc <- unsuperClass(so, nClasses=3) # questa funzione crea in uscita il modello e la mappa. Utilizziamo 3 classi.
plot(soc$map) # facciamo plot dell'immagine classificata e visto che vogliamo vedere la mappa la leghiamo a quest'ultima

# Classificazione non supervisionata con 20 classi, diamo un nuovo nome per non sovrascrivere sul precedente
sot <- unsuperClass(so, nClasses=20)
plot(sot$map)

# Immagine scaricata da:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("sun.png")

# Classificazione non supervisionata con 3 classi
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map, col=cl)

cl <- colorRampPalette(c('yellow','purple','pink'))(100)
plot(sunc$map, col=cl)

# la funzione "mask" serve per nascondere il rumore dato dalla presenza delle nuvole

# Gran Canyon 
# https://landsat.visibleearth.nasa.gov/view.php?id=80948
# rifacciamo lo stesso procedimento con i dati scaricati sul Gran Canyon
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")

plotRGB(gc, r=1, g=2, b=3, stretch="lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)

gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)


#--------------------------------------------


# 7. R code ggplot2

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("~/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra


#--------------------------------------------


# 8. R code vegetation indices

# R_code_vegetation_indices.r

library(raster) # require(raster)
library(RStoolbox) # per il calcolo degli indici di vegetazione

# install.packages("rasterdiv")

# per l'indice NDVI del pianeta
library(rasterVis)

setwd("C:/lab/")

defor1<-brick("defor1.jpg")
defor2<-brick("defor2.jpg")

# b1= NIR, b2= red, b3= green

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin") # vediamo le due immagine sulla stessa colonna, si nota la grande diminuzione di vegetazione della foresta amazzonica

# calcoliamo il primo indice di vegetazione

defor1 # andiamo a vedere il nome delle bande aprendo tutte le informazioni del file e vediamo che il NIR si chiama defor1.1 e il RED defor1.2

dvi1 <- defoder1$defor1.1-defor1$defor1.2 # per ogni pixel prendiamo il valore nel NIR e sottraiamo il valore nel RED, si crea una mappa composta dalla differenza dei pixel = DVI

plotdvi1
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifichiamo lo schema dei colori in modo che si veda bene la vegetazione in rosso

plot(dvi1, col=cl, main="DVI at time 1") # in questo modo visualizziamo il DVI che abbiamo appena calcolato

# calcoliamo l'indice di vegetazione per la seconda immagine
dvi2 <- defor2$defor2.1-defor2$defor2.2

plotdvi2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)

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

ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
# si potrebbe anche fare ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)


plot(ndvi1)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)

plot(ndvi1, col=cl)

ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)

# Rstoolbox: spectralIndices
# si può usare la funzione spectralIndices che calcola diversi indici multrispettrali
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot (vi1, col=cl)

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot (vi2, col=cl)

difndvi <- ndvi1 - ndvi2 # vediamo la differenza tra gli indici di vegetazione delle due immagini normalizzati
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)

# worldwilde NDVI
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA)) # per oscurare i valori dell'acqua che non ci interessano
plot(copNDVI)

# è necessario richiamare il pacchetto rasterVis
levelplot(copNDVI) # immagine che mostra i valori di biomassa della Terra


#--------------------------------------------


# 9. R code land cover

# abbiamo riutilizzato gli algoritmi di classificazione delle immagini e abbiamo fatto un'analisi multi temporale della variazione della copertura del suolo. 

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

# classificazione non supervisionata, garantisce di non agire in modo soggettivo
d1c <- unsuperClass(defor1, nClasses=2)

d1c
plot(d1c$map) 
# classe 1 agricola
# classe 2 foresta
# set.seed() per permetterti di ottenere gi stessi risultati

d2c <- unsuperClass(defor2, nClasses=2)

d2c
plot(d2c$map) 
# classe 1 agricola
# classe 2 foresta

d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map) 
# classe 3 foresta
# classe 1 e 2 due tipi diversi di coltivazione

# frequenze
freq(d1c$map) # calcola l afrequenza di delle due classi nella mappa che abbiamo generato
# value  count
# [1,]     1  33575
# [2,]     2 307717

s1 <- 33575 + 307717

prop1 <- freq(d1c$map) / s1 # calcoliamo la proporzione delle frequenze
# prop coltivazioni agricole: 0.09837617
# prop foresta: 0.90162383

s2 <- 342726
prop2 <- freq(d2c$map) / s2
# prop coltivazioni agricole: 0.4769174
# prop foresta: 0.5230826

# si possono anche calcolare le percentuali moltiplicando per cento

# build a dataframe
# facciamo una tabella che contenga questi risultati
cover <- c("Forest", "Agriculture") # prima colonna. Siccome è un vettore di due diversi blocchi devo mettere "c"
percent_1992 <- c(90.16, 9.84)
percent_2006 <- c(52.31, 47.69)

percentages <- data.frame (cover, percent_1992, percent_2006)
#    cover percent_1992 percent_2006
# 1      Forest        90.16        52.31
# 2 Agriculture         9.84        47.69

# plottiamo con la funzione ggplot le percentuali di cover di foresta e coltivazioni
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="light blue")

ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="light blue")

# creiamo un unico grafico
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="light blue")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="light blue")

grid.arrange(p1, p2, nrow=1)


#--------------------------------------------


# 10. R code variability

# abbiamo analizzato l'eterogeneità del paesaggio e potenzialmente mineralogica di alcune zone

# R_code_variability.r
# Analizziamo pattern spaziali tramite l’uso di indici del paesaggio nell’area del ghiacciao del Similaun

library(raster)
library(RStoolbox)
library(ggplot2) # per ploottare ggplot
library(gridExtra) # per plottare insieme ggplot
#install.packages("viridis")
library(viridis) # serve per colorare i plot automaticamente

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
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd) # w= window. prendiamo una finestra di 3x3 pixel
plot(ndvisd3)

clsd <- colorRampPalette(c('blue', 'green', 'pink', 'magenta', 'orange', 'brown', 'red', 'yellow'))(100)
plot(ndvisd3, col=clsd) # la deviazione standard del NDVI è più bassa dove è presente la roccia nuda ed aumenta in corrispondenza del passaggio alla vegetazione per poi diminuire di nuovo nelle parti vegetate

# calcoliamo la media del ndvi con focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)

clsd <- colorRampPalette(c('blue', 'green', 'pink', 'magenta', 'orange', 'brown', 'red', 'yellow'))(100)
plot(ndvimean3, col=clsd) # media per 3 pixel. si ottengono valori molti alti nelle praterie di alta quota e per la parte seminaturale. valori più bassi per la roccia nuda

# cambiamo la finestra: 11x11 pixel
ndvisd11 <- focal(ndvi, w=matrix(1/121, nrow=11, ncol=11), fun=sd) 
clsd <- colorRampPalette(c('blue', 'green', 'pink', 'magenta', 'orange', 'brown', 'red', 'yellow'))(100)
plot(ndvisd11, col=clsd) # se ho un immagine con dettagli molto alti è meglio usare una finestra più piccola. finestre troppo grandi rischiano di omogenizzare il risultato.

# cambiamo la finestra: 5x5 pixel
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd) # situazione ideale per identicare le variazioni della deviazione standard
clsd <- colorRampPalette(c('blue', 'green', 'pink', 'magenta', 'orange', 'brown', 'red', 'yellow'))(100)
plot(ndvisd5, col=clsd)         

# PCA: analisi multivariata su tutto il dataset e poi prendiamo la PC1 (unico strato) per fare una finestra e calcolare una mappa di deviazione standard
sentpca <- rasterPCA(sent) # fa l'analisi dei componenit principali per il raster
plot(sentpca$map) # la prima componente mantiene il range di iniformazione più alto. passando alle PC successive l'informazione si perde

sentpca # $call= funzione che abbiamo usato. $model= princomp(cor = spca, comvmat = covMat[[1]]). cor= correlazione, covmat= matrice di covarianza. $map : RasterBrick 

summary(sentpca$model) # per vedere quanta variabilità iniziale spiegano le singole componenti
# la prima PC spiega il 0.6736804 dell'informazione originale.

pc1 <- sentpca$map$PC1
pc1_5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue', 'green', 'pink', 'magenta', 'orange', 'brown', 'red', 'yellow'))(100)
plot(pc1_5, col=clsd) # molto ben visibile la variabilità del paesaggio


#con la funzione source si possono caricare codici presi da fuori
source("source_test_lezione.r.txt") # abbiamo preso un pezzo di codice scaricandolo come documento di testo e lo abbiamo aperto direttamente con R
# pc1 <- sentpca$map$PC1
# pc1sd7 <- focal(pc1, w=matrix(1/49, nrow=7, ncol=7), fun=sd)
# plot(pc1sd7)
source("source_ggplot.r.txt")

# facciamo un plottaggio con ggplot, metodo migliore per individuare discontinuità a livello geografico, a livello geologico serve per individuare variabilità geomorfologica e a livello ecologico serve a individuare variabilità ecologica (ecotoni)
p1 <- ggplot() +
geom_raster(pc1_5, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() + # non specifichiamo il tipo di legenda viridis
ggtitle("Standard deviation of PC1 by viridis colour scale")

# cambiamo il tipo di legenda per i colori
p2 <- ggplot() +
geom_raster(pc1_5, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="magma") + 
ggtitle("Standard deviation of PC1 by magma colour scale")

p3 <- ggplot() +
geom_raster(pc1_5, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="turbo") + 
ggtitle("Standard deviation of PC1 by turbo colour scale")

# per ottenere i 3 plot con le legende e posso confrontare le diverse elgende dei colori
grid.arrange(p1, p2, p3, nrow=1)


#--------------------------------------------


# 11. R code spectral signatures

# R_code_spectral_signatures.r

library(raster)
library(ggplot2)
library(rgdal)

setwd("C:/lab/")


# carichiamo tutte le bande
defor2 <- brick("defor2.jpg")

# defor2.1, defor2.2, defor2.3
#NIR, red, green

plotRGB(defor2, r=1, g=2, b=3, stretch="lin") # si può anche fare stretch histogram stretch che usa una curva logistica per aumentare la pendenza della curva e le differenze saranno + accentuate.
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

# usiamo l'immagine per creare delle firme spettrali, crreremo anche un piccolo dataset per vederle in ggplot
# click function serve per cliccare sulla mappa e ottenere informazioni

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")   # id=identicativo, xy informazioni spaziali, T=2, type di click=point, pch è il tipo di punto, cex caracter exageration

# cliccando otteniamo informazioni su xy, numero della cella, dare informazioni sulla mappa: riflettanza nelle tre bande, il primo molto alto perchè NIr perchè abbiamo cliccato sulla vegetazione

#      x     y   cell defor2.1 defor2.2 defor2.3
#1 135.5 246.5 165763      189       11       23
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 177.5 187.5 208108       21       42       95


# creiamo un dataframe che poi utilizziamo, useremo poi ggplot per creare le firme spettrali
# 3 bande, foresta o acqua con i valori delle bande e poi useremo il dataframe

# define the columns of the dataset
band <- c(1,2,3)
forest <- c(189, 11, 23)
water <- c(21, 42, 95)

# create the dataframe
spectrals <- data.frame(band, forest, water)
spectrals

# plot the spectral signatures: facciamo un grafico in cui viene mostrata la riflettanza dei due pixel (foresta e acqua) nelle 3 bande

ggplot(spectrals, aes(x=band)) + # aes= aestetics e serve oer fissare l'asse
 geom_line(aes(y=forest), color="green") + # in questog rafico abbiamo la riflettanza di un singolo pixel della foresta nella tre bande: tanat nella banda uno, bassa nella 2 + alta nella 3
 geom_line(aes(y=water), color="blue") +
 labs(x="wavelenght", y="reflectance")  #labs function serve per modificare gli assi le legende..
 
 
 ############## Multitemporal, vediamo la differenza tra defor1 e defor2, prendiamo dei punti a caso dove è presente una differenza nelle immagini
 
defor1 <- brick("defor1.jpg")

plotRGB(defor1, r=1, g=2, b=3, stretch="lin") 
 
 # spectral signatures defor1
 
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

#      x     y  cell defor1.1 defor1.2 defor1.3
# 1 35.5 347.5 92856       99       15        5
#      x     y  cell defor1.1 defor1.2 defor1.3
# 1 58.5 388.5 63605      210       37       57
#      x     y  cell defor1.1 defor1.2 defor1.3
# 1 80.5 376.5 72195      219       16       35
#      x     y   cell defor1.1 defor1.2 defor1.3
# 1 84.5 313.5 117181      217       11       31


plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 60.5 336.5 101158      166      169      158
#      x     y  cell defor2.1 defor2.2 defor2.3
# 1 57.5 375.5 73192      177      124      132
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 43.5 336.5 101141      141       95       95
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 103.5 292.5 132749      131       63       74
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 96.5 326.5 108364      185      158      149


# definiamo le colonne del dataset

band <- c(1,2,3)
time1 <- c(99, 15, 5) # primo pixel
time1p2 <- c(210, 37, 57) # secondo pixel
time2 <- c(166, 169, 158)
time2p2 <- c(177, 124, 132)

spectralst <- data.frame(band, time1, time2, time1p2, time2p2)

ggplot(spectralst, aes(x=band)) + # aes= aestetics e serve per fissare l'asse
 geom_line(aes(y=time1), color="red") + # in questog rafico abbiamo la riflettanza di un singolo pixel della foresta nella tre bande: tanat nella banda uno, bassa nella 2 + alta nella 3
 geom_line(aes(y=time2), color="gray") +
 geom_line(aes(y=time1p2), color="red") +
 geom_line(aes(y=time2p2), color="gray") +
 labs(x="wavelenght", y="reflectance")
 
 # plot the spectral signatures
 ggplot(spectralst, aes(x=band)) + 
 geom_line(aes(y=time1), color="red", linetype="dotted") + 
 geom_line(aes(y=time2), linetype="dotted") +
 geom_line(aes(y=time1p2), color="red", linetype="dotted") +
 geom_line(aes(y=time2p2), linetype="dotted") +
 labs(x="wavelenght", y="reflectance")
 
# image from Earth Observatory
 
eo <- brick("iss063e054142.jpg")
plotRGB(eo, 1,2,3, stretch="hist") 
click(eo, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

 
#       x     y   cell iss063e054142.1 iss063e054142.2 iss063e054142.3
# 1 186.5 435.5 190267               6               4               5
#       x     y  cell iss063e054142.1 iss063e054142.2 iss063e054142.3
# 1 208.5 602.5 70049             225             222             217
#       x     y  cell iss063e054142.1 iss063e054142.2 iss063e054142.3
# 1 655.5 608.5 66176              40              63              81


# definiamo le colonne del dataset

band <- c(1,2,3)
crater <- c(6,4,5)
fog <- c(225, 222, 217)
water <- c(40, 63, 81)

spectralseo <- data.frame(band, crater, fog, water)
spectralseo

band <- c(1,2,3)
crater <- c(6,4,5)
fog <- c(225, 222, 217)
water <- c(40, 63, 81)

spectralseo <- data.frame(band, crater, fog, water)
spectralseo

ggplot(spectralseo, aes(x=band)) + 
 geom_line(aes(y=crater), color="red") + 
 geom_line(aes(y=fog), color="gray") +
 geom_line(aes(y=water), color="blue") +
 labs(x="wavelenght", y="reflectance")


#--------------------------------------------












