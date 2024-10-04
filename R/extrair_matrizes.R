#' @title Modelo
#' @param dados data.frame. O banco de dados contendo as variáveis.
#' @param formula fórmula. Fórmula no formato Y ~ x1 + x2 + ... + xn.
#' @return Uma lista contendo as matrizes das variáveis preditoras e resposta.
#'
#' @details
#' A função transforma os dados de entrada em matrizes para facilitar o cálculo
#' da regressão, separando as variáveis preditoras e resposta.
#'
#' @examples
#' extrair_matrizes(dados, Crescimento_PIB ~ Inflacao + Gastos_Governamentais)
#'
#' @description
#' Recebe um banco de dados e uma fórmula e retorna duas matrizes:
#' uma matriz X com as variáveis explicativas e uma matriz Y com a variável resposta,
#' preparadas para serem utilizadas na função betas.
#'
#' @return Uma lista contendo a matriz X (explicativas) e a matriz Y (resposta).
#' @export

modelo = function(dados, formula) {

  # Construir a matriz de variáveis explicativas (X) e a variável resposta (Y)
  model_matrix = model.matrix(formula, data = dados)  # Cria a matriz X incluindo intercepto
  y = model.response(model.frame(formula, data = dados))  # Extrai a variável resposta (Y)

  # Remover a coluna de intercepto da matriz X, caso tenha sido incluída
  x = model_matrix[, -1, drop = FALSE]

  # Converter y para uma matriz
  y = as.matrix(y)

  # Retornar as matrizes X e Y
  return(list(X = x, Y = y))
}
