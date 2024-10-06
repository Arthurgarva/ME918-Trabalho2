library(testthat)

# Teste para Coluna Constante
test_that("Teste com coluna constante", {
  # Coluna X1 é constante
  X <- matrix(c(rep(1, 100), rnorm(100)), ncol = 2)
  Y <- rnorm(100)

  modelo_resultado1 <- modelo(data.frame(X1 = X[,1], X2 = X[,2], Y = Y), Y ~ X1 + X2)

  expect_warning({
    regressao(modelo_resultado1, 1)
  }, regexp = "A coluna de X é constante")
})

test_that("Teste com posto incompleto", {
  # X1 e X2 são linearmente dependentes (posto incompleto) sem serem constantes
  X <- matrix(c(1:100, 2:101), ncol = 2)  # X2 é dependente de X1 (X2 = X1 + 1)
  Y <- rnorm(100)

  modelo_resultado2 <- modelo(data.frame(X1 = X[,1], X2 = X[,2], Y = Y), Y ~ X1 + X2)

  # Testa apenas se a função emite o warning específico de regularização Ridge
  expect_warning(
    regressao(modelo_resultado2, 1),
    regexp = "A matriz não tem posto completo. Aplicada regularização Ridge, o resultado pode não ser eficaz."
  )
})




# Teste para Resíduos Zero (ajuste perfeito, mas posto completo)
test_that("Teste com resíduos zero", {
  # X1 e X2 são independentes
  X <- matrix(c(1:100, runif(100, 50, 150)), ncol = 2)  # X2 é independente de X1
  beta <- c(2, 3)
  Y <- X %*% beta  # Y é uma combinação linear perfeita de X1 e X2

  modelo_resultado3 <- modelo(data.frame(X1 = X[,1], X2 = X[,2], Y = Y), Y ~ X1 + X2)

  expect_warning({
    regressao(modelo_resultado3, 1)
  }, regexp = "Os resíduos são todos iguais a zero")
})
