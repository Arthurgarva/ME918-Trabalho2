#' @title Resíduos
#' @param x matrix. Matriz com as variáveis explicativas.
#' @param y matrix. Matriz com a variável resposta.
#' @return Um vetor com os resíduos, que são a diferença entre os valores observados e os preditos.
#'
#' @details
#' A função calcula os resíduos, que são a diferença entre os valores observados e
#' os valores preditos pelo modelo de regressão.
#'
#' @examples
#' residuos(X, Y)
#' @description
#' Calcula os resíduos da regressão, que são definidos como a diferença entre os valores observados e os preditos.
#' @return Retorna um vetor com os resíduos.
#' @export
residuos = function(x, y){
  y_pred = preditos(x, y)
  residuos = y - y_pred  # Diferença entre os valores observados e preditos
  return(residuos)
}
