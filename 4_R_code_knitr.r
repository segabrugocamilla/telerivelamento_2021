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
