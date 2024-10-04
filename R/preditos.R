#' @title Preditos
#' @param x matrix. Matriz com as variáveis explicativas de treino.
#' @param y matrix. Matriz com a variável resposta.
#' @return Um vetor com os valores ajustados (ou preditos) do modelo.
#' @details
#' A função utiliza os coeficientes estimados pela função betas() e aplica-os à
#' matriz X para prever os valores de Y. O resultado é um vetor com os valores preditos.
#' @examples
#' preditos(X, Y)
#' @description
#' Calcula os valores preditos dentro do próprio conjunto de dados de treino.
#' @return Retorna um vetor com os valores preditos.
#' @export
preditos = function(x, y) {
  # Calcular os betas
  betas_estimados = betas(x, y)

  # Adicionar a coluna de 1's (intercepto) à matriz x
  coluna1 = rep(1, nrow(x))
  k = cbind(coluna1, x)

  # Multiplicar k pelos betas
  y_pred = k %*% betas_estimados

  return(y_pred)
}

