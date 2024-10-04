library(teste)
install.packages("roxygen2")
library(roxygen2)
install.packages("htmltools")

library(devtools)
setwd("C:/Users/Arthur/Desktop/Estatistica/me918/trabalho 2")

devtools::document()
dados<-ibge


# Aplicar a função modelo para extrair X e Y
modelo_resultado = modelo(dados, Crescimento_PIB ~ Inflacao + Gastos_Governamentais + Exportacoes)


# Aplicar a função regressao para calcular betas, p-valores e resíduos
resultado_regressao = regressao(modelo_resultado,1)

grafico_residuos(resultado_regressao=resultado_regressao)
grafico_p_o(resultado_regressao)

novos_dados <- data.frame(
  Gastos_Governamentais = c(45.782, 50.145, 60.345, 48.237, 53.876),  # Valores fixos para Gastos Governamentais
  Investimento_Estrangeiro = c(87.234, 93.876, 91.564, 85.342, 92.457),  # Valores fixos para Investimento Estrangeiro
  Exportacoes = c(110.345, 98.754, 104.765, 100.432, 108.675)  # Valores fixos para Exportacoes
)

# Converter o data frame 'novos_dados' em uma matriz numérica
novos_dados_matrix <- as.matrix(novos_dados)

# Realizar a predição com a matriz convertida
valores_preditos = predicao(modelo_resultado, novos_dados_matrix)

# Ver os valores preditos
print(valores_preditos)


#testes
usethis::use_testthat()
devtools::test()














