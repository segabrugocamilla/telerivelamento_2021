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
rlist<-list.files(pattern="lst") #abbiamo fatto la lista dei files che contenevano "lst"
rlist

#Apply a function over a list-like or vector-like object
#lapply(X, FUN, ...)
import <- lapply(rlist,raster) #abbiamo applicato la funzione "raster" alla lista "rlist" precedentemente creata
import

TGr <- stack(import) #la funzione stack crea un unico file grande che comprende tutti i dati
plot(TGr)

#creiamo un file composto dalle temperature nei vari anni su un'unica immagine
plotRGB(TGr, 1, 2, 3, stretch="Lin") # dall'abbondanza di blu si nota che ci sono valori più alti del 2010)
plotRGB(TGr, 2, 3, 4, stretch="Lin")
