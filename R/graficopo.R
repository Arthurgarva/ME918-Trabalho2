#' @title Gráfico Observados vs Preditos
#' @param resultado_regressao list. O resultado da função regressao().
#' @return Um gráfico comparativo entre os valores preditos e observados.
#' @details
#' A função plota os valores preditos contra os valores observados para
#' fornecer uma visão visual da qualidade do ajuste do modelo.
#' @examples
#' grafico(X, Y)
#' @description
#' Gera um gráfico comparando os valores preditos e os observados dentro do conjunto de dados de treino.
#' @return Um gráfico de comparação de valores preditos vs observados, exibido na tela.
#' @export

grafico_p_o = function(resultado_regressao) {

  # Extrair os valores preditos e observados (y)
  y_pred = resultado_regressao$valores_preditos$y_pred  # Valores preditos
  y_observado = resultado_regressao$valores_y  # Valores observados (resposta)

  # Verificar se os comprimentos de y_pred e y_observado são compatíveis
  if (length(y_pred) != length(y_observado)) {
    stop("Os comprimentos de valores preditos e observados não correspondem.")
  }

  # Definir os limites dos eixos para o gráfico
  limite_total = range(c(y_pred, y_observado))

  # Criar o gráfico de dispersão Preditos vs Observados
  plot(y_observado, y_pred,
       main = "Valores Preditos vs Observados",
       xlab = "Valores Observados",
       ylab = "Valores Preditos",
       xlim = limite_total, ylim = limite_total,
       pch = 16, col = "blue")  # pch define o símbolo e col a cor

  # Adicionar uma linha de referência y = x (predito igual ao observado)
  abline(0, 1, col = "red", lty = 2)  # Linha tracejada vermelha de y = x
}
