library(teste)
install.packages("roxygen2")
library(roxygen2)
install.packages("htmltools")

library(devtools)
setwd("C:/Users/Arthur/Desktop/Estatistica/me918/trabalho 2")

devtools::document()

################################################################################
#Teste para erros

# Data frame 1: Coluna constante
df_col_const <- data.frame(
  X1 = c(1, 1, 1, 1, 1),
  X2 = c(2, 3, 4, 5, 6),
  Y = c(2.5, 3.0, 3.5, 4.0, 4.5)
)

# Data frame 2: Matriz de posto incompleto
df_post_inc <- data.frame(
  X1 = c(1, 2, 3, 4, 5),
  X2 = c(2, 4, 6, 8, 10),
  Y = c(3, 6, 9, 12, 15)
)

# Data frame 3: Resíduos todos iguais a zero (ajuste perfeito)
set.seed(123)
X1 <- rnorm(100, mean = 10, sd = 5)
X2 <- runif(100, min = 50, max = 150)

# Criando o data frame com Y como uma combinação linear exata de X1 e X2
df_res_zero_corrigido <- data.frame(
  X1 = X1,
  X2 = X2,
  Y  = 2 * X1 + 3 * X2
)


#Teste 1
modelo_resultado1 = modelo(df_col_const, Y ~ X1 + X2)
resultado_regressao1 = regressao(modelo_resultado1,1)

#Teste 2
modelo_resultado2 = modelo(df_post_inc, Y ~ X1 + X2)
resultado_regressao2 = regressao(modelo_resultado2,1)

#Teste 3
modelo_resultado3 = modelo(df_res_zero_corrigido, Y ~ X1 + X2)
resultado_regressao3 = regressao(modelo_resultado3, 1)

################################################################################
#Teste com banco de dados próprio (Funcional)


dados<-ibge

# Aplicar a função modelo para extrair X e Y
modelo_resultado = modelo(dados, Crescimento_PIB ~ Inflacao + Gastos_Governamentais + Exportacoes)


# Aplicar a função regressao para calcular betas, p-valores e resíduos
resultado_regressao = regressao(modelo_resultado,1)

grafico_residuos(resultado_regressao=resultado_regressao)
grafico_p_o(resultado_regressao)

novos_dados <- data.frame(
  Gastos_Governamentais = c(45.782, 50.145, 60.345, 48.237, 53.876),
  Investimento_Estrangeiro = c(87.234, 93.876, 91.564, 85.342, 92.457),
  Exportacoes = c(110.345, 98.754, 104.765, 100.432, 108.675)
)

novos_dados_matrix <- as.matrix(novos_dados)

# Realizar a predição com a matriz convertida
valores_preditos = predicao(modelo_resultado, novos_dados_matrix)

# Ver os valores preditos
print(valores_preditos)


#testes
usethis::use_testthat()
devtools::test()














