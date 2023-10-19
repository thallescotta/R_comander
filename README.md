---
title: "Atividade 01: Análise exploratoria de dados"
author: "Thalles Cotta Fontainha"
date: "`r Sys.Date()`"  # Uses current date
---
#### Disciplina: Estatística Aplicada à Projetos de Pesquisa

<!-- 
You can edit this R Markdown document, for example to explain what you're
doing and to draw conclusions from your data analysis. 

Auto-generated section titles, typically preceded by ###, can also be edited. 

It's generally not a good idea to edit the R code that the R Commander writes, 
but you can freely edit between (not within) R "code blocks." Each R code
block starts with ```{r} and ends with ```.
-->


```{r echo=FALSE, message=FALSE}
# include this code chunk as-is to set options
knitr::opts_chunk$set(comment=NA, prompt=TRUE)
library(Rcmdr)
library(car)
library(RcmdrMisc)
```

### (Exercício 1): Abra o arquivo ebmt3.RData no R Commander.

```{r}
load("/home/sony/Documentos/Mestrado/Conjuntos_de_dados_v2_Thalles/ebmt3.RData")
```


```{r}
setwd("/home/sony/Documentos/Mestrado/Conjuntos_de_dados_v2_Thalles")
```





### (Exercício 2) Faça uma tabela de frequências para cada uma das variáveis: age e rfsstat. Quais os percentuais de cada faixa etária e de mortalidade/recidiva no estudo?

### Frequencies: age, rfsstat
```{r}
local({
  .Table <- with(ebmt3, table(age))
  cat("\ncounts:\n")
  print(.Table)
  cat("\npercentages:\n")
  print(round(100*.Table/sum(.Table), 2))
})

![ex2.1](https://github.com/thallescotta/R_comander/blob/master/figure/2.1.png)

local({
  .Table <- with(ebmt3, table(rfsstat))
  cat("\ncounts:\n")
  print(.Table)
  cat("\npercentages:\n")
  print(round(100*.Table/sum(.Table), 2))
})
```
![ex2.2](https://github.com/thallescotta/R_comander/blob/master/figure/2.2.png)


#### (Resposta 2): No arquivo ebmt3.RData a distribuição percentual da população em diferentes faixas etárias é a seguinte: 19,01% têm idade igual ou inferior a 20 anos, 47,96% têm idade entre 20 e 40 anos, e 33,03% têm idade superior a 40 anos.


### (Exercício 3) Faça uma tabela de dupla entrada com as variáveis age (linhas) e rfsstat (colunas), solicitando que sejam mostrados os percentuais nas linhas. Quais os percentuais de pacientes que sobreviveram em cada faixa etária? 



```{r}
library(abind, pos=16)
```



### Two-Way Contingency Table: age, rfsstat
```{r}
local({
  .Table <- xtabs(~age+rfsstat, data=ebmt3)
  cat("\nFrequency table:\n")
  print(.Table)
  cat("\nRow percentages:\n")
  print(rowPercents(.Table))
})
```

![ex3](https://github.com/thallescotta/R_comander/blob/master/figure/3)

#### (Resposta 3): Sabendo que "rfstime" é Tempo em dias desde o transplante até a recidiva ou morte ou último acompanhamento (tempo de sobrevivência livre de recidiva). 
#### Pacientes com idade <=20 anos: 70.4% sobreviveram (censura), 29.6% enfrentaram morte ou recidiva.
#### Pacientes com idade entre 20-40 anos: 64.9% sobreviveram, 35.1% enfrentaram morte ou recidiva.
#### Pacientes com idade >40 anos: 52.5% sobreviveram, enquanto 47.5% enfrentaram morte ou recidiva.


### (Exercício 4) Obtenha a média, mediana, P25, P75 das variáveis prtime e rfstime para cada faixa etária.

```{r}
library(e1071, pos=17)
```

### Resumos Numéricos: ebmt3
```{r}
numSummary(ebmt3[,c("prtime", "rfstime"), drop=FALSE], groups=ebmt3$age, statistics=c("mean", "sd", "IQR", "quantiles"), quantiles=c(.25,.75))
```

![ex4](https://github.com/thallescotta/R_comander/blob/master/figure/4)

#### (Resposta 4): 
#### Em prtime; A média (mean) para idade <= 20 : 389.2912  
#### Em prtime; O desvio padrão (sd) para idade <= 20 : 633.2222  
#### Em prtime; A média (mean) para idade entre 20-40 : 466.8714  
#### Em prtime; O desvio padrão (sd) para idade entre 20-40 : 690.9332  
#### Em prtime; A média (mean) para idade entre > 40 : 426.0810  
#### Em prtime; O desvio padrão (sd) para idade > 40 : 649.4042  
#### e  
#### Em rfstime; A média (mean) para idade <= 20 : 992.4535  
#### Em rfstime; O desvio padrão (sd) para idade <= 20 : 728.4596  
#### Em rfstime; A média (mean) para idade entre 20-40 : 959.9716  
#### Em rfstime; O desvio padrão (sd) para idade entre 20-40 : 746.0292  
#### Em rfstime; A média (mean) para idade entre > 40 : 850.8558  
#### Em rfstime; O desvio padrão (sd) para idade > 40 : 720.6033  



### (Exercício 5): Faça um diagrama de barras lado a lado e condicional, com as percentagens da variável rfsstat para cada categoria da variável tcd. Comente o gráfico.


### Bar Plot: rfsstat
```{r}
with(ebmt3, Barplot(rfsstat, by=tcd, style="parallel", legend.pos="above", xlab="rfsstat", ylab="Percent", main="Exercicio 5", scale="percent", label.bars=TRUE))
```
![ex5](https://github.com/thallescotta/R_comander/blob/master/figure/ex5)

#### (Resposta 5): Sabendo que "tcd": depleção de células T ("No TCD", "TCD"). Entre o grupo "censura", 90% tinham "No TCD" enquanto 10% tinham "TCD". Já em "morte/recidiva" 84% tinham "No TCD" enquanto 16% tinham "TCD".


### (Exercício 6): Faça um boxplot da variável rfstime para cada subclassificação da doença. Comente o gráfico.

### Boxplot: rfstime ~ dissub
```{r}
Boxplot(rfstime ~ dissub, data=ebmt3, id=list(method="none"), main="Boxplot do Exercício 6")
```
![ex6](https://github.com/thallescotta/R_comander/blob/master/figure/ex6)

#### (Resposta 6): O boxplot é uma ferramenta visual útil para entender como o tempo de sobrevivência livre de recidiva (rfstime) varia entre diferentes subtipos de leucemia, como AML, ALL e CML. Ele mostra a mediana, quartis e valores extremos, oferecendo uma visão completa da distribuição desses dados. Ao observar o boxplot, os profissionais de saúde podem identificar facilmente casos incomuns em cada subtipo, fornecendo insights valiosos que podem exigir uma atenção especial na análise e tomada de decisões clínicas.

#### (Comentário do gráfico do exercício 6): A linha mais grossa é a mediana, o percentil 25 a parte de baixo, entre 0 e 500 no eixo y (rfstime) enquanto o percentil 75, valores proximos de 1500 no eixo y também. Ou seja, em geral os 3 tipos de subtipos de leucemia (AML, ALL, CML) possuem comportamento semelhante em termos de rfstime (tempo de sobrevivência livre de recidiva) com valores de mediana proximas também. E também não possem valores de "outlier" que é um valor que se afasta significativamente do padrão geral desse conjunto de dados expresso.


### (Exercício 7): Faça um histograma de frequência relativa da variável rfstime. Comente o gráfico.


### Histogram: rfstime
```{r}
with(ebmt3, Hist(rfstime, scale="frequency", breaks="Sturges", col="darkgray", main="Histograma de frequência relativa da variável rfstime"))
```
![ex7](https://github.com/thallescotta/R_comander/blob/master/figure/ex7)

#### (Resposta 7): No histograma, nota-se que a maioria das ocorrências (frequência) está concentrada entre 0 e 500 dias no eixo do tempo de sobrevivência livre de recidiva (rfstime), representado no eixo horizontal (x). Este eixo mostra o tempo desde o transplante até a recidiva, morte ou último acompanhamento. O eixo vertical (y) reflete a quantidade de ocorrências dentro dessa faixa de tempo. 

