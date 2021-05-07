# R_code_knitr.r

setwd("C:/lab/") #settiamo la working directory, da cui prenderemo il nostro codice originale per fare il "report"

library(knitr)

stitch("R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr")) #utiliziammo la funzione stitch per andare a prendere il codice
# in questo caso avendo windows si è generato un file.tex che va trasformato in pdf -> usiamo overleaf
