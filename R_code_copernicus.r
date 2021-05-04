#R_code_copernicus.r
#Visualizzazione dei dati corpernicus
#abbiamo bisogno della libreria raster e ncdf4 per leggere questo formato di dati

library(raster)
install.packages("ncdf4")
library(ncdf4)

setwd("C:/lab/")
library(raster)

FAPAR <- raster("c_gls_FAPAR-RT0_202006300000_GLOBE_PROBAV_V2.0.1.nc")
FAPAR

#facciamo il primo plot di quesat immagine, non montiamo sulle bande RGB perchè abbiamo solo uno strato e possiamo decidere la scala di colori da usare
cl <- colorRampPalette(c('pink','red','orange','yellow'))(100)
plot(FAPAR,col=cl)

#questo dato si può ricampionare per renderlo più gestibile, prendiamo un pixel più grande es estraiamo la media di quelli più piccoli contenuti. es. con fact=10 diminuisco di 10 volte
FAPARes <- aggregate(FAPAR, fact=100) #ricampionamento bilineare (10000 volte il dato originale)
plot(FAPARes, col=cl)
