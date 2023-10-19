load("/home/sony/Documentos/Mestrado/Conjuntos_de_dados_v2_Thalles/ebmt3.RData")
setwd("/home/sony/Documentos/Mestrado/Conjuntos_de_dados_v2_Thalles")
local({
  .Table <- with(ebmt3, table(age))
  cat("\ncounts:\n")
  print(.Table)
  cat("\npercentages:\n")
  print(round(100*.Table/sum(.Table), 2))
})
local({
  .Table <- with(ebmt3, table(rfsstat))
  cat("\ncounts:\n")
  print(.Table)
  cat("\npercentages:\n")
  print(round(100*.Table/sum(.Table), 2))
})
library(abind, pos=16)
local({
  .Table <- xtabs(~age+rfsstat, data=ebmt3)
  cat("\nFrequency table:\n")
  print(.Table)
  cat("\nRow percentages:\n")
  print(rowPercents(.Table))
})
library(e1071, pos=17)
numSummary(ebmt3[,c("prtime", "rfstime"), drop=FALSE], groups=ebmt3$age, statistics=c("mean", "sd", "IQR", "quantiles"), quantiles=c(.25,.75))


with(ebmt3, Barplot(rfsstat, by=tcd, style="parallel", legend.pos="above", xlab="rfsstat", ylab="Percent", main="Exercicio 5", scale="percent", label.bars=TRUE))


Boxplot(rfstime ~ dissub, data=ebmt3, id=list(method="none"), main="Boxplot do Exercício 6")



with(ebmt3, Hist(rfstime, scale="frequency", breaks="Sturges", col="darkgray", main="Histograma de frequência relativa da variável rfstime"))

