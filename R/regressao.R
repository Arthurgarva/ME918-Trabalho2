#' @title Regressão
#' @param modelo_retorno list. O retorno da função modelo(), contendo as matrizes X e Y.
#' @param R numeric. Parâmetro opcional para indicar se os resultados devem ser impressos (R = 1).
#' @return Uma lista contendo os coeficientes da regressão, p-valores, resíduos, R² e R² ajustado.
#'
#' @details
#' A função realiza a regressão linear, ajusta o modelo e, em caso de multicolinearidade,
#' utiliza regularização Ridge para estabilizar o cálculo. Retorna os principais indicadores
#' como betas, p-valores, resíduos, R² e R² ajustado.
#'
#' @examples
#' modelo_resultado <- regressao(dados, Crescimento_PIB ~ Inflacao + Gastos_Governamentais)
#' @description
#' Aplica as funções betas, p_valores e residuos às matrizes X e Y fornecidas e retorna os resultados das três funções.
#' Se o parâmetro R for igual a 1, os resultados serão impressos na tela.
#' @return Uma lista contendo os coeficientes (betas), os p-valores para cada beta, e os resíduos da regressão.
#' @export
regressao = function(modelo_retorno, R = 0) {
  x = modelo_retorno$X
  y = modelo_retorno$Y
  nomes_variaveis = colnames(x)

  # Adicionar intercepto à matriz X (coluna de 1s)
  X <- cbind(1, x)  # Intercepto na matriz X

  # 1. Verificar se alguma coluna (além do intercepto) de X é constante
  if (any(apply(X[, -1], 2, function(col) all(col == col[1])))) {
    warning("A coluna de X é constante")
  }
  # 2. Verificar se a matriz X tem posto completo
  else if (qr(X)$rank < ncol(X)) {
    warning("A matriz não tem posto completo. Aplicada regularização Ridge, o resultado pode não ser eficaz.")
    # Aplicar regularização Ridge em caso de posto incompleto
    betas_resultado <- betas(x, y)  # A função `betas` já lida com a regularização Ridge
    y_pred = X %*% betas_resultado  # Calcular os valores preditos
    residuos_resultado <- y - y_pred  # Calcular os resíduos
    p_valores_resultado = p_valores(x, y)

    # Função para formatar a saída com p-valores e asterisco
    format_output = function(betas, p_valores, nomes_variaveis) {
      resultado = c()
      resultado[1] = sprintf("%-25s %15s %15s", "Variável", "Coeficiente", "P-valor")
      for (i in 1:length(betas)) {
        beta_nome = if (i == 1) "Intercepto" else nomes_variaveis[i - 1]
        beta_valor = sprintf("%15.4f", betas[i])
        p_valor = ifelse(is.na(p_valores[i]), "NA", sprintf("%15.4f", p_valores[i]))
        asterisco = ifelse(!is.na(p_valores[i]) && as.numeric(p_valores[i]) < 0.05, "*", "")
        resultado[i + 1] = sprintf("%-25s %15s %15s%s", beta_nome, beta_valor, p_valor, asterisco)
      }
      return(resultado)
    }

    # Calcular R² e R² ajustado
    r2_resultados = calcular_r2(modelo_retorno)

    # Se R == 1, imprimir os resultados
    if (R == 1) {
      cat("Resumo dos Resíduos:\n")
      print(summary(as.numeric(residuos_resultado)))
      cat("\n")
      resultado_formatado = format_output(betas_resultado, p_valores_resultado, nomes_variaveis)
      for (linha in resultado_formatado) {
        cat(linha, "\n")
      }
      cat("\nR²: ", sprintf("%.4f", r2_resultados$r2), "\n")
      cat("R² Ajustado: ", sprintf("%.4f", r2_resultados$r2_ajustado), "\n")
    }

    # Retornar os resultados
    return(list(
      betas = betas_resultado,
      p_valores = p_valores_resultado,
      residuos = residuos_resultado,
      r2 = r2_resultados$r2,
      r2_ajustado = r2_resultados$r2_ajustado,
      valores_preditos = y_pred,
      valores_y = modelo_retorno$Y
    ))
  }
  # 3. Verificar se os resíduos são todos iguais a zero (Y pode ser perfeitamente descrito por Xβ)
  else {
    betas_resultado = betas(x, y)  # Calcular os betas
    y_pred = X %*% betas_resultado  # Calcular os valores preditos
    residuos_resultado <- y - y_pred  # Calcular os resíduos

    if (all(abs(residuos_resultado) < 1e-10)) {  # Verificar se todos os resíduos são essencialmente zero
      warning("Os resíduos são todos iguais a zero")
    } else {
      # Calcular p-valores
      p_valores_resultado = p_valores(x, y)

      # Função para formatar a saída com p-valores e asterisco
      format_output = function(betas, p_valores, nomes_variaveis) {
        resultado = c()
        resultado[1] = sprintf("%-25s %15s %15s", "Variável", "Coeficiente", "P-valor")
        for (i in 1:length(betas)) {
          beta_nome = if (i == 1) "Intercepto" else nomes_variaveis[i - 1]
          beta_valor = sprintf("%15.4f", betas[i])
          p_valor = ifelse(is.na(p_valores[i]), "NA", sprintf("%15.4f", p_valores[i]))
          asterisco = ifelse(!is.na(p_valores[i]) && as.numeric(p_valores[i]) < 0.05, "*", "")
          resultado[i + 1] = sprintf("%-25s %15s %15s%s", beta_nome, beta_valor, p_valor, asterisco)
        }
        return(resultado)
      }

      # Calcular R² e R² ajustado
      r2_resultados = calcular_r2(modelo_retorno)

      # Se R == 1, imprimir os resultados
      if (R == 1) {
        cat("Resumo dos Resíduos:\n")
        print(summary(as.numeric(residuos_resultado)))
        cat("\n")
        resultado_formatado = format_output(betas_resultado, p_valores_resultado, nomes_variaveis)
        for (linha in resultado_formatado) {
          cat(linha, "\n")
        }
        cat("\nR²: ", sprintf("%.4f", r2_resultados$r2), "\n")
        cat("R² Ajustado: ", sprintf("%.4f", r2_resultados$r2_ajustado), "\n")
      }

      # Retornar os resultados
      return(list(
        betas = betas_resultado,
        p_valores = p_valores_resultado,
        residuos = residuos_resultado,
        r2 = r2_resultados$r2,
        r2_ajustado = r2_resultados$r2_ajustado,
        valores_preditos = y_pred,
        valores_y = modelo_retorno$Y
      ))
    }
  }
}
