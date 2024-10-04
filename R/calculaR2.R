#' @title R² e R² Ajustado
#' @param modelo_retorno list. O retorno da função modelo(), contendo as matrizes X e Y.
#' @return Uma lista contendo o R² e o R² ajustado.
#'
#' @details
#' A função compara os valores observados com os preditos e calcula a
#' proporção da variabilidade explicada pelo modelo (R²) e uma versão ajustada
#' que considera o número de variáveis explicativas (R² ajustado).
#'
#' @examples
#' calcular_r2(modelo)
#' @description
#' Calcula o R² e o R² ajustado a partir de uma regressão linear.
#' @return Retorna uma lista contendo o R² e o R² ajustado.
#' @export
calcular_r2 = function(modelo_retorno) {
  # Extraindo as matrizes X e Y do retorno da função modelo
  x = modelo_retorno$X
  y = modelo_retorno$Y

  # Estimando os betas (coeficientes)
  betas_estimados = betas(x, y)

  # Predição com os dados de treino
  y_pred = preditos(x, y)

  # Soma total dos quadrados (SST)
  ss_total = sum((y - mean(y))^2)

  # Soma dos quadrados dos resíduos (SSR)
  ss_residual = sum((y - y_pred)^2)

  # Calcular o R²
  r2 = 1 - (ss_residual / ss_total)

  # Calcular o R² ajustado
  n = nrow(x)  # Número de observações
  p = ncol(x)  # Número de variáveis explicativas
  r2_ajustado = 1 - ((1 - r2) * (n - 1) / (n - p - 1))

  # Retornar uma lista com R² e R² ajustado
  return(list(
    r2 = r2,
    r2_ajustado = r2_ajustado
  ))
}
