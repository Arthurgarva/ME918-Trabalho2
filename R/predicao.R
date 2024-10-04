#' @title Predição
#' @param modelo Um modelo de regressão ajustado.
#' @param dados O conjunto de dados utilizado para realizar as predições.
#' @return Um vetor numérico com os valores preditos.
#' @details
#' Esta função usa os coeficientes estimados pelo modelo de regressão e aplica-os
#' às variáveis preditoras para calcular os valores preditos de Y.
#' Se houver multicolinearidade, a regularização Ridge é aplicada.
#' @examples
#' modelo_resultado <- modelo(dados, Crescimento_PIB ~ Inflacao + Gastos_Governamentais)
#' predicao(modelo_resultado, dados)
#' @param modelo_retorno list. O retorno da função modelo(), contendo as matrizes X e Y.
#' @param z matrix. Matriz com os novos valores das variáveis explicativas (sem o intercepto).
#' @description
#' Calcula os valores preditos para um novo conjunto de dados utilizando os coeficientes estimados no conjunto de treino.
#' @return Retorna um data frame com as variáveis preditoras e os valores preditos.
#' @export
predicao = function(modelo_retorno, z) {
  # Extraindo as matrizes X e Y do retorno da função modelo
  x = modelo_retorno$X
  y = modelo_retorno$Y

  # Estimando os betas (coeficientes)
  betas_estimados = betas(x, y)

  # Verifica se as dimensões de z são compatíveis com x
  if (ncol(z) != ncol(x)) {
    stop("As dimensoes dos novos dados (z) não são compatíveis com o conjunto de treino.")
  }

  # Remover o coeficiente do intercepto (primeiro beta)
  coeficientes = betas_estimados[-1, , drop = FALSE]

  # Multiplicar os coeficientes pelos novos dados (sem intercepto)
  pre_erro = z %*% coeficientes

  # Soma o intercepto aos valores preditos
  y_novo = pre_erro + betas_estimados[1, ]

  # Retornar um data frame com as variáveis preditoras e o valor predito
  resultado = data.frame(z, y_pred = y_novo)

  return(resultado)
}
