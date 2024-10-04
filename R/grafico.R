#' @title Gráfico Resíduos vs Preditos
#' @param resultado_regressao list. O resultado da função regressao().
#' @return Um gráfico de dispersão comparando os valores preditos e os resíduos dentro do conjunto de dados.
#' @details
#' A função plota os valores preditos contra os valores observados para
#' fornecer uma visão visual da qualidade do ajuste do modelo.
#' @examples
#' grafico(X, Y)
#' @description
#' Gera um gráfico de dispersão comparando os valores preditos e os resíduos dentro do conjunto de dados de treino.
#' @return Um gráfico de dispersão exibido na tela.
#' @export
grafico_residuos = function(resultado_regressao) {

  # Extrair os valores preditos e os resíduos do resultado da função regressao
  y_pred = resultado_regressao$valores_preditos$y_pred # Valores preditos
  residuos = resultado_regressao$residuos  # Resíduos

  # Criar o gráfico de dispersão base usando plot()
  plot(y_pred, residuos,
       main = "Resíduos vs Valores Preditos",
       xlab = "Valores Preditos",
       ylab = "Resíduos",
       pch = 16, col = "blue")  # pch define o símbolo e col a cor

  # Adicionar uma linha horizontal de referência em y = 0
  abline(h = 0, col = "red", lty = 2)  # Linha tracejada horizontal em y = 0
}


