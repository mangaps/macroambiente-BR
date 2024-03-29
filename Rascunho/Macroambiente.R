## Pacotes

install.packages("tidyverse")
install.packages("gridExtra")


library(tidyverse)
library(readxl)
library(ggplot2)
library("gridExtra")

## Diret�rio

setwd("C:/Users/henri/Data/Macroambiente-BR")

## Dados PIB
pib <- read_excel("C:/Users/henri/Data/Macroambiente-BR/PIB-IBGE-Menor.xlsx")
View(pib)

## Dados Desocupa��o
## Link https://www.ibge.gov.br/estatisticas/sociais/habitacao/9173-pesquisa-nacional-por-amostra-de-domicilios-continua-trimestral.html?edicao=20653&t=series-historicas

Desocupacao <- read_excel("C:/Users/henri/Data/Macroambiente-BR/Desocupacao-Menor.xlsx")
View(Desocupacao)

#Cria��o da tabela base para o gr�fico

Pibdesoc <- pib %>%
  left_join(Desocupacao, by = "Data")%>%
  mutate(Per�odo = Data)

View(Pibdesoc)

#Gr�fico

p1 <- ggplot(Pibdesoc, aes(x=Per�odo, y=PIB, group = 1))+
  geom_line(color="blue")+
  geom_point()+
  labs(title = "PIB brasileiro por trimestre a partir de 2014", subtitle = "Em milh�es de reais", caption = "Fonte: Sistema de Contas Nacionais Trimestrais - SCNT (IBGE)")

p2 <- ggplot(Pibdesoc, aes(x = Per�odo, y=Desocupacao))+
  geom_line(color="green")+
  geom_point()+
  labs(title = "Taxa de desocupa��o da popula��o brasileira a partir de 2014", subtitle = "Em porcentagem", caption = "Fonte: Pesquisa Nacional por Amostra de Domic�lios Cont�nua - PNAD Cont�nua (IBGE)")


#Multiplot function

multiplot <- function(..., plotlist = NULL, file, cols = 1, layout = NULL) {
  require(grid)
  
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  if (is.null(layout)) {
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots == 1) {
    print(plots[[1]])
    
  } else {
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    for (i in 1:numPlots) {
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}


multiplot(p1, p2, cols=1)
#> `geom_smooth()` using method = 'loess'



#outros
install.packages("grid")
rmarkdown::render("README.Rmd")


#json
