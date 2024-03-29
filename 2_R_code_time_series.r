# Time series analysis
# Greenland aumento della temperatura
# Dati e codici presi da un progetto di Emanuela Cosma

# install.packages ("raster")
# install.packages("rasterVis")

library(raster)
library(rasterVis) # metodi di visualizzazione per i raster

setwd("C:/lab/greenland")

# analizziamo dati sulla temperatura e sullo strato del ghiaccio della Groellandia

# STACK -> funzione utilizzata per trasformare dati disponibili come colonne separate in un dataframe o lista avente una singola colonna che può essere utilizzato nello studio dei modelli di variaanza o altri modelli lineari
# utilizziamo la funzioen raster presente nel pacchetto raster per creare un oggetto RasterLayer

lst_2000 <- raster("lst_2000.tif") # importiamo e associamo un nome a un singolo raster
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

#vogliamo creare una lista di files in una Directory/Folder
#utiliazziamo la funzione: list.files
rlist<-list.files(pattern="lst") #abbiamo fatto la lista dei files che contenevano "lst" e lo associamo all'oggetto "rlist"
rlist

#lapply è una funzione che può essere usara su oggetti che siano liste o vettori 
#lapply(X, FUN, ...) -> applica un'altra funzione a una lista di files
import <- lapply(rlist,raster) #abbiamo applicato la funzione "raster" alla lista "rlist" precedentemente creata e l'abbiamo associato all'oggetto "import". in questo modo importiamo la lista di files
import

TGr <- stack(import) #la funzione stack crea un unico file grande che comprende tutti i dati che associamo all'oggetto "TGr"
plot(TGr)

#creiamo un file composto dalle temperature nei vari anni su un'unica immagine
plotRGB(TGr, 1, 2, 3, stretch="Lin") # dall'abbondanza di blu si nota che ci sono valori più alti del 2010
plotRGB(TGr, 2, 3, 4, stretch="Lin")

library(rasterVis) #che abbiamo installato per supportare la funzione "levelplot"

levelplot(TGr) # mostra le 4 immagini satellitari con le variazioni di temperatura
levelplot(TGr$lst_2000) # il grafico, mostra l'andatura media della temperatura per colonna, lo stesso a destra per riga

cl <- colorRampPalette(c("pink","purple","orange","light blue"))(100) #cambiamo la colorRampPalette, possiamo farlo perchè plottiamo delle immagini singole e non un'immagine satellitare in RGB
levelplot(TGr, col.regions=cl)

levelplot(TGr,col.regions=cl,names.attr=c("July 2000","July 2005","July 2010","July 2015")) #rinominiamo gli attributi per le 4 immagini nel grafico

#inseriamo il titolo
levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005","July 2010","July 2015"))


#usiamo i dati Melt (dati sullo scioglimento dei ghiacciai dal 1979 al 2007)

meltlist<-list.files(pattern="melt") # facciamo una lista con tutti i dati melt
importmelt <- lapply(meltlist,raster) #con "lapply" applichiamo la funzione "raster" alla lista
melt <- stack(importmelt) # creiamo un "raster stack"
melt 

levelplot(melt) #otteniamo il grafico con i valori dello sciogliemto dei ghiacci dal 1979 al 2007
          
# facciamo la sottrazione tra il primo dato e il secondo e creiamo un file con la differenza
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt #dobbiamo legare il file orginario allo strato interno

clb <- colorRampPalette(c("blue","white","red"))(100) #creiamo la colorRampPalette
plot(melt_amount, col=clb) # viene così evedenziato dove c'è stato una grande diminuizione del ghiaccio dal 1979 al 2007 (zona rossa)
levelplot(melt_amount) #mostra la media dei valori di scioglimento nei pixel per colonna e riga

# abbiamo visto come visualizzare un set di dati numerosi e anche come osservarne le differenze di valori

