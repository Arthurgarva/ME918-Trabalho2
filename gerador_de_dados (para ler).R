# Gerar o conjunto de dados com uma seed fixa
set.seed(123)  # Seed fixa para reprodutibilidade

n <- 100
X1 <- rnorm(n, mean = 50, sd = 10)  # Gastos Governamentais
X2 <- rnorm(n, mean = 100, sd = 20) # Investimento Estrangeiro
X3 <- rnorm(n, mean = 80, sd = 15)  # Exportações

X <- cbind(X1, X2, X3)

# Coeficientes para as variáveis dependentes
beta_Y1 <- c(2.5, -0.8, 0.6)  # Coef Crescimento do PIB
beta_Y2 <- c(-1.5, 0.9, -0.4)  # Coef Inflação

# Erros aleatórios
epsilon_Y1 <- rnorm(n, mean = 0, sd = 1)
epsilon_Y2 <- rnorm(n, mean = 0, sd = 1)

# Variáveis dependentes com erro
Y1 <- X %*% beta_Y1 + epsilon_Y1  # Crescimento do PIB
Y2 <- X %*% beta_Y2 + epsilon_Y2  # Inflação

# Criar o data frame final
ibge <- data.frame(
  Crescimento_PIB = Y1,
  Inflacao = Y2,
  Gastos_Governamentais = X1,
  Investimento_Estrangeiro = X2,
  Exportacoes = X3
)
usethis::use_data(ibge, overwrite = TRUE)
