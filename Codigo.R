#Configurando o diretório de trabalho
setwd("C:/Users/Eric/")
getwd()

#intalando os pacotes
install.packages('dplyr')
install.packages('arules')
install.packages('arulesViz')
install.packages('htmlwidgets')
install.packages('writexl')

# Carrega os pacotes
library(dplyr)                 
library(arules)            #pacote para regras de associação.        
library(arulesViz)             #visualiza as regras de associação
library(htmlwidgets)          
library(writexl)               
options(warn=-1)                


# Carrega e explora o dataset
dados <- read.csv("dataset_bd3.csv")
dim(dados)
View(dados)
summary(dados)
str(dados)



# Uma forma inteligente de resolver o problema no dataset
# Separamos as linhas pares das linhas ímpares
linhas_pares <- seq(2, nrow(dados), 2)
linhas_impares <- seq(1, nrow(dados), 2)



# Separamos os dados e então usaremos o dataset com as linhas pares (linhas de dados válidos)
df1 <- dados[linhas_pares, ]
View(df1)
df2 <- dados[linhas_impares, ] 
View(df2)



# Verifica se temos valores ausentes (N/A) no primeiro item de compra
sum(is.na(df1$Item01))



# Verifica se temos valores ausentes no segundo item de compra (ATENÇÃO)
sum(is.na(df1$Item02))
View(df1)



# Verifica se temos valores ausentes representados por espaço em branco
which(nchar(trimws(df1$Item01))==0)
which(nchar(trimws(df1$Item02))==0)



# Verifica se temos valores ausentes representados por espaço em branco (usando expressão regular)
#o grepl retorna se tem ou não caracter na string
grepl("^\\s*$", df1$Item02)



# Número de itens distintos (produtos)
n_distinct(df1)


#Faz sentido ter transaçãoes com apenas um produto ? 
# Vamos trabalhar somente com os registros onde o item 2 não fos nulo
df1_two <- df1[!grepl("^\\s*$", df1$Item02), ]



# Número de itens distintos (produtos)
n_distinct(df1_two)
View(df1_two)


# Prepara o pacote convertendo as variáveis para o tipo fator 
#É necessário manter todas as colutas ? 
#muitas colunas aumenta a espacidade e dificulta o processamento
# (variáveis que usaremos daqui em diante)
View(df1_two)
str(df1_two)
pacote <- df1_two
pacote$Item01 <- as.factor(pacote$Item01)
pacote$Item02 <- as.factor(pacote$Item02)
pacote$Item03 <- as.factor(pacote$Item03)
pacote$Item04 <- as.factor(pacote$Item04)
pacote$Item05 <- as.factor(pacote$Item05)
pacote$Item06 <- as.factor(pacote$Item06)
summary(pacote)
View(pacote)
str(pacote)

?split 
#(fazer um filtro)
pacote_split <- split(pacote$Item01, 
                      pacote$Item02,
                      pacote$Item03, 
                      pacote$Item04,
                      pacote$Item05, 
                      pacote$Item06)

View(pacote_split)


# PDF métricas sobre o algoritomo APriori

#Começando a extrair as regras de associação 


# Transações / as para converter o objeto para a classe transactions 
?as
transacoes <- as(pacote_split, "transactions")



# Inspeção das regras de maneira geral
inspect(head(transacoes, 5))

?inspect

# Vamos verificar as regras de um produto: Dust-Off Compressed Gas 2 pack
?apriori
regras_produto1 <- apriori(transacoes, 
                           parameter = list(conf = 0.5, minlen = 3),
                           appearance = list(rhs = "Dust-Off Compressed Gas 2 pack", default = "lhs")) 



# Inspeção das regras
inspect(head(sort(regras_produto1, by = "confidence"), 5))



# Vamos verificar as regras de um produto: HP 61 ink
regras_produto2 <- apriori(transacoes,
                           parameter = list(minlen = 3, conf = 0.5),
                           appearance = list(rhs = "HP 61 ink",default = "lhs"))

# Inspeção das regras
inspect(head(sort(regras_produto2, by = "confidence"), 5))

# Vamos verificar as regras de um produto: VIVO Dual LCD Monitor Desk mount
regras_produto3 <- apriori(transacoes,
                           parameter = list(minlen = 3, conf = 0.5),
                           appearance = list(rhs = "VIVO Dual LCD Monitor Desk mount", default = "lhs"))

# Inspeção das regras
inspect(head(sort(regras_produto3, by = "confidence"), 5))



                      ###as regras que não são relevantes ou são redundantes####



# Vamos verificar novamente as regras do produto: Dust-Off Compressed Gas 2 pack, 
# alterando uma das métricas / adicionando a métrica support 

regras_produto1 <- apriori(transacoes, 
                           parameter = list(minlen = 3, supp = 0.2, conf = 0.5, target = "rules"),
                           appearance = list(rhs = "Dust-Off Compressed Gas 2 pack", default = "lhs")) 

# Inspeção das regras
inspect(head(sort(regras_produto1, by = "confidence"), 5))

   

# Filtra as regras redundantes
regras_produto1_clean <- regras_produto1[!is.redundant(regras_produto1)]


# Inspeção das regras
inspect(head(sort(regras_produto1_clean, by = "confidence"), 5))

# Sumário
summary(regras_produto1_clean)


# Plot
plot(regras_produto1_clean, measure = "support", shading = "confidence", method = "graph", engine = "html")

# Vamos verificar novamente as regras do produto: HP 61 ink,
# alterando uma das métricas
regras_produto2 <- apriori(transacoes,
                           parameter = list(minlen = 3, supp = 0.2, conf = 0.5, target = "rules"),
                           appearance = list(rhs = "HP 61 ink", default = "lhs"))

# Inspeção das regras
inspect(head(sort(regras_produto2, by = "confidence"), 5))



# Filtra as regras redundantes
regras_produto2_clean <- regras_produto2[!is.redundant(regras_produto2)]



# Inspeção das regras
inspect(head(sort(regras_produto2_clean, by = "confidence"), 5))



# Sumário
summary(regras_produto2_clean)



# Plot
plot(regras_produto2_clean, measure = "support", shading = "confidence", method = "graph", engine = "html")


# Vamos verificar novamente as regras do produto: VIVO Dual LCD Monitor Desk mount,
# alterando uma das métricas
regras_produto3 <- apriori(transacoes,
                           parameter = list(minlen = 3, supp = 0.2, conf = 0.5, target = "rules"),
                           appearance = list(rhs = "VIVO Dual LCD Monitor Desk mount", default = "lhs"))

# Inspeção das regras
inspect(head(sort(regras_produto3, by = "confidence"), 5))

# Filtra as regras redundantes
regras_produto3_clean <- regras_produto3[!is.redundant(regras_produto3)]

# Inspeção das regras
inspect(head(sort(regras_produto3_clean, by = "confidence"), 5))

# Sumário
summary(regras_produto3_clean)

# Plot
plot(regras_produto3_clean, measure = "support", shading = "confidence", method = "graph", engine = "html")



# Top 3 regras
#head = listar uma sequencia
#sort =  ordenar 
#inspect = inspensionar
#decreasing =  TRUE / do menor para o maior
inspect(head(sort(regras_produto1_clean, by = "support", decreasing = TRUE), 1))
inspect(head(sort(regras_produto2_clean, by = "confidence", decreasing = TRUE), 1))
inspect(head(sort(regras_produto3_clean, by = "confidence", decreasing = TRUE), 1))
#Qual é a principal regra para o produto número 1, 2 e 3? 

# Salvamos o conjunto de regras dos 3 produtos como dataframe  e então salvamos em disco
View(regras_produto1_clean)
df_produto1 <- as(regras_produto1_clean, "data.frame")
View(df_produto1)
write_xlsx(df_produto1, "df_produto1.xlsx")

df_produto2 <- as(regras_produto2_clean, "data.frame")
View(df_produto2)
write_xlsx(df_produto2, "df_produto2.xlsx")

df_produto3 <- as(regras_produto3_clean, "data.frame")
View(df_produto3)
write_xlsx(df_produto3, "df_produto3.xlsx")




