# R_code_land_cover.r

#install.packages("RStoolbox")
#install.packages("ggplot2")
#install.packages("gridExtra")

library(raster)
library(RStoolbox) #per la classificazione
library(ggplot2)
library(gridExtra) #per grid.arrange plotting

setwd("C:/lab/") # Windows

# NIR 1, RED 2, GREEN 3

defor1<-brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch= "lin") # plottiamo l'immagine in RGB

# necessari i pacchetti "RStoolbox" e "ggplot" per fare il seguente plot
ggRGB(defor1, r=1, g=2, b=3, stretch= "lin") # creiamo un immagine singola delle 3 bande

defor2<-brick("defor2.jpg")
ggRGB(defor2, r=1, g=2, b=3, stretch= "lin") # facciamo lo stesso procedimento con la seconda immagine

# mettiamo a confronto le due immagini
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# per fare un multiframe delle due immagini con ggplot2 bisogna utilizzare la funzione "grid.arrange"
# necessario installare "gridExtra"

# multiframe con ggplot2 e gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch= "lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch= "lin")
grid.arrange(p1,p2, nrow=2)

# classificazione non supervisionata, viene fatto tutto dal software e garantisce di non agire in modo soggettivo
d1c <- unsuperClass(defor1, nClasses=2)

d1c
plot(d1c$map) 

# classe 1 agricola
# classe 2 foresta

# Set.seed() per permetterti di ottenere gi stessi risultati

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
 # calcolo la frequenza di delle due classi nella mappa che abbiamo generato, es. con che frequenza sono presenti i pixel foresta?
freq(d1c$map)

# value  count
# [1,]     1  33575
# [2,]     2 307717

#vogliamo fare la proporzione, quindi prima facciamo una somma
s1 <- 33575 + 307717

prop1 <- freq(d1c$map) / s1 # calcoliamo la proporzione delle frequenze
# prop coltivazioni agricole: 0.09837617
# prop foresta: 0.90162383


#facciamo lo stesso per la seconda mappa
s2 <- 342726
prop2 <- freq(d2c$map) / s2
# prop coltivazioni agricole: 0.4769174
# prop foresta: 0.5230826


#costruiamo un dataframe
#creiamo una la colonna con i fattori: variabili categoriche (non numeriche)
#in questo caso i fattori sono foreste e agricoltura
#se il valore è una parola mettiamo le virgolette altrimenti non mettiamo niente

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
