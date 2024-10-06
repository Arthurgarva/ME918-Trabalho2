#' @title P-valores para cada beta
#' @param x matrix. Matriz com as variáveis explicativas.
#' @param y matrix. Matriz com a variável resposta.
#' @return Um vetor com os p-valores associados a cada coeficiente.
#'
#' @details
#' A função utiliza os coeficientes e a matriz de covariância para calcular os
#' p-valores com base na distribuição t de Student.
#'
#' @examples
#' p_valores(betas, cov_matrix)
#' @description
#' Calcula o p-valor para cada coeficiente da regressão (beta), assumindo que o erro segue uma distribuição normal.
#' Retorna uma lista dos coeficientes com seus p-valores e um asterisco ao lado se o p-valor for menor que 0.05.
#' @return Uma lista com os betas e seus p-valores.
#' @export
p_valores = function(x, y) {
  n = nrow(x)
  p = ncol(x)

  # Adicionar a coluna de intercepto
  coluna1 = rep(1, n)
  X = cbind(coluna1, x)

  # Calcular X'X
  XtX = t(X) %*% X

  # Verificar se a matriz é singular ou mal-condicionada
  if (det(XtX) == 0 || rcond(XtX) < 1e-10) {
    # Aplicar regularização Ridge
    lambda = 1e-4 * max(abs(diag(XtX)))  # Ajustar lambda dinamicamente
    XtX_ridge = XtX + diag(lambda, ncol(XtX))
    beta = solve(XtX_ridge) %*% (t(X) %*% y)
    inv_xtx = solve(XtX_ridge)
  } else {
    # Sem regularização
    beta = betas(x, y)
    inv_xtx = solve(XtX)
  }

  # Calcular variância dos resíduos
  residuos = residuos(x, y)
  sigma2 = sum(residuos^2) / (n - p)

  # Calcular os erros padrão dos betas
  se_beta = sqrt(diag(sigma2 * inv_xtx))

  # Calcular os valores t
  t_valores = beta / se_beta

  # Calcular os p-valores usando a distribuição t
  p_valores = 2 * pt(-abs(t_valores), df = n - p)

  return(p_valores)
}

