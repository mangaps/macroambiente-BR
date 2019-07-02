install.package("jsonlite")
library(jsonlite)


data <- fromJSON("https://servicodados.ibge.gov.br/api/v1/conjunturais?&d=s&user=ibge&t=1846&v=585&p=199601-205701&ng=1(1)&c=11255(90707)")

View(data)

#cria coluna nova com valor de data parseado

data$date <- ifelse(grepl("1� trimestre", data$p), gsub("1� trimestre ", "01-03-", data$p), 
                    ifelse(grepl("2� trimestre", data$p), gsub("2� trimestre ", "01-06-", data$p), 
                           ifelse(grepl("3� trimestre", data$p), gsub("3� trimestre ", "01-09-", data$p),
                                  ifelse(grepl("4� trimestre", data$p), gsub("4� trimestre ", "01-12-", data$p),"no"))))


# corrige o formato da data da coluna Date
library(lubridate)
data$date <- dmy(data$date)

#corrige formato do dado na coluna V
data$v <- as.integer(data$v)
