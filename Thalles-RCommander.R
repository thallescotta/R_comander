
load("C:/Users/F193865.STARONE/Downloads/Conjuntos_de_dados (1)/ebmt3.RData")
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

