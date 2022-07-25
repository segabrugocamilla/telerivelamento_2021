#R_code_copernicus.r
#Visualizzazione dei dati corpernicus
#abbiamo bisogno della libreria raster e ncdf4 per leggere questo formato di dati

#install.packages("raster")
# install.packages("ncdf4")


library(raster)
library(ncdf4)

setwd("C:/lab/")

FAPAR <- raster("c_gls_FAPAR-RT0_202006300000_GLOBE_PROBAV_V2.0.1.nc") # importiano i dati in R e rinominiamo
FAPAR

#facciamo il primo plot di questa immagine, non montiamo sulle bande RGB perchè abbiamo solo uno strato e possiamo decidere la scala di colori da usare
cl <- colorRampPalette(c('pink','red','orange','yellow'))(100)
plot(FAPAR,col=cl)

#questo dato si può ricampionare per renderlo più gestibile, prendiamo un pixel più grande e ad esempio estraiamo la media di quelli più piccoli contenuti. es. con fact=10 diminuisco di 10 volte
#Consideriamo che abbiamo detto lineare quindi dobbiamo calcolare nel nostro caso 10x10 (quindi ogni 100 pixel ne uscirà uno che ha la media dei valori di tutti e 100)
#Questo tipo di ricampionamento viene definito Bilineare
FAPARes <- aggregate(FAPAR, fact=100) #ricampionamento bilineare (10000 volte il dato originale)
plot(FAPARes, col=cl) #Qui vedremo infine il plot del file ricampionato con la nostra palette creata in precedenza.
