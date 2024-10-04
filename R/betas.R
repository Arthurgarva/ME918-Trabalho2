#' @title betas
#' @param x matrix. Matriz com as variáveis explicativas (preditoras).
#' @param y matrix. Matriz com a variável resposta.
#' @return Um vetor com os coeficientes da regressão (betas).
#'
#' @details
#' A função calcula os coeficientes (betas) da regressão linear usando a fórmula
#' clássica de mínimos quadrados:
#'
#' \deqn{\beta = (X^T X)^{-1} X^T Y}
#'
#' Se a matriz \(X^T X\) for singular, a regularização Ridge será aplicada para
#' garantir a estabilidade dos coeficientes.
#'
#' @examples
#' betas(X, Y)
#' @description
#' Calcula os coeficientes (betas) da regressão linear utilizando a fórmula: β̂ = (X'X)^(-1)X'Y.
#' A primeira coluna da matriz x representa o intercepto (adicionado automaticamente).
#' @return Retorna uma matriz com os coeficientes da regressão.
#' @export
betas = function(x, y) {
  Intercepto = rep(1, nrow(x))
  k = cbind(Intercepto, x)  # Adicionar o intercepto

  XtX = t(k) %*% k

  if (det(XtX) == 0) {
    # Definir lambda automaticamente
    lambda = 1e-4 * max(abs(diag(XtX)))

    # Aplicar regularização Ridge sem imprimir avisos
    XtX_ridge = XtX + diag(lambda, ncol(XtX))
    return(solve(XtX_ridge) %*% (t(k) %*% y))
  } else {
    return(solve(XtX) %*% (t(k) %*% y))
  }
}





