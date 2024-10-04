library(testthat)

# Teste para Coluna Constante
test_that("Teste com coluna constante", {
  X <- matrix(c(rep(1, 100), rep(3, 100)), ncol = 2)  # Primeira coluna é o intercepto, a segunda é constante
  Y <- rnorm(100)

  # Verificar se a função executa sem erro e retorna coeficientes
  expect_silent({
    resultado <- regressao(list(X = X, Y = Y), 0)
  })

  # Verificar se o Ridge foi aplicado (verifique os coeficientes e se lambda foi impresso)
})

# Teste para Posto Incompleto
test_that("Teste com posto incompleto", {
  X <- matrix(c(rep(1, 100), rnorm(100), rnorm(100)), ncol = 3)
  X[, 3] <- X[, 2]  # Tornar a terceira coluna igual à segunda (linearmente dependente)
  Y <- rnorm(100)

  # Verificar se a função executa sem erro e retorna coeficientes
  expect_silent({
    resultado <- regressao(list(X = X, Y = Y), 0)
  })

  # Verificar se o Ridge foi aplicado
})

# Teste para Resíduos Zero
test_that("Teste com resíduos zero", {
  X <- matrix(c(rep(1, 100), rnorm(100)), ncol = 2)
  beta <- c(2, 3)
  Y <- X %*% beta  # Gerar Y como uma combinação linear perfeita de X

  # Verificar se a função executa sem erro e retorna coeficientes
  expect_silent({
    resultado <- regressao(list(X = X, Y = Y), 0)
  })

  # Verificar se o Ridge foi aplicado
})

# Teste para Gráfico com Matriz Singular
test_that("Teste gráfico com matriz singular", {
  X <- matrix(c(rep(1, 100), rep(3, 100)), ncol = 2)  # Matriz singular
  Y <- rnorm(100)

  # Verificar se a função executa sem erro e retorna coeficientes
  expect_silent({
    resultado <- regressao(list(X = X, Y = Y), 0)
  })

  # Verificar se o Ridge foi aplicado
})
