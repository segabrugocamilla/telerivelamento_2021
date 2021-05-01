# Time series analysis
# Greenland increase of temperature
# Data and code from Emanuela Cosma

# install.packages ("raster")
library(raster)

setwd("C:/lab/greenland")

lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)

lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)

lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

# par
par(mfrow=c(2,2))
plot(lst_2005)
plot(lst_2000)
plot(lst_2010)
plot(lst_2015)

#we wont to list the files in a Directory/Folder
#list.files
rlist<-list.files(pattern="lst") #abbiamo fatto la lista dei files che contenevano "lst" e lo associamo all'oggetto "rlist"
rlist

#Apply a function over a list-like or vector-like object
#lapply(X, FUN, ...)
import <- lapply(rlist,raster) #abbiamo applicato la funzione "raster" alla lista "rlist" precedentemente creata e l'abbiamo associato all'oggetto "import"
import

TGr <- stack(import) #la funzione stack crea un unico file grande che comprende tutti i dati che associamo all'oggetto "TGr"
plot(TGr)

#creiamo un file composto dalle temperature nei vari anni su un'unica immagine
plotRGB(TGr, 1, 2, 3, stretch="Lin") # dall'abbondanza di blu si nota che ci sono valori più alti del 2010)
plotRGB(TGr, 2, 3, 4, stretch="Lin")

library(rasterVis) #che abbiamo installato per supportare la funzione "levelplot"

levevlplot(TGr) #abbiamo le 4 immagini satellitari
levelplot(TGr$lst_2000) #il grafico sopra mostra l'andatura media della temperatura per colonna, lo stesso a destra per righe

cl <- colorRampPalette(c("pink","purple","orange","light blue"))(100) #cambiamo la colorRampPalette, possiamo farlo perchè plottiamo delle immagini singole e non un'immagine satellitare in RGB
levelplot(TGr, col.regions=cl)

levelplot(TGr,col.regions=cl,names.attr=c("July 2000","July 2005","July 2010","July 2015")) #rinominiamo gli attributi (le 4 immagini nel grafico)


# usiamo i dati Melt

meltlist<-list.files(pattern="melt") # facciamo una lista con tutti i dati melt
importmelt <- lapply(meltlist,raster) # applichiamo la funzione "raster" alla lista
melt <- stack(importmelt) # creiamo un "raster stack"
melt 

levelplot(melt) #otteniamo il grafico con i valori dello sciogliemto dei ghiacci dal 1979 al 2007
          
# facciamo la sottrazione tra il primo dato e il secondo e creiamo un file con la differenza
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt

clb <- colorRampPalette(c("blue","white","red"))(100) #creiamo la colorRampPalette
plot(melt_amount, col=clb) # viene così evedenziato dove c'è stato una grande diminuizione del ghiaccio dal 1979 al 2007
# abbiamo visto come visualizzare un set di dati numerosi e anche le loro differenze

