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
  nomes_variaveis = colnames(x)  # Obter os nomes das variáveis explicativas

  # Aplicar as funções
  betas_resultado = betas(x, y)
  p_valores_resultado = p_valores(x, y)
  residuos_resultado = residuos(x, y)

  # Calcular os valores preditos usando a função preditos
  y_pred = preditos(x, y)

  # Função para formatar a saída com p-valores e asterisco
  format_output = function(betas, p_valores, nomes_variaveis) {
    resultado = c()  # Vetor para armazenar os resultados formatados
    # Adiciona o cabeçalho com espaçamento maior
    resultado[1] = sprintf("%-25s %15s %15s", "Variável", "Coeficiente", "P-valor")

    for (i in 1:length(betas)) {
      # Formatar o nome dos coeficientes
      if (i == 1) {
        beta_nome = "Intercepto"  # O primeiro coeficiente é o intercepto
      } else {
        beta_nome = nomes_variaveis[i - 1]  # Usar o nome real da variável
      }

      # Formatar os valores de betas e p-valores com espaçamento uniforme
      beta_valor = sprintf("%15.4f", betas[i])  # Formata com 4 casas decimais e 15 espaços de largura
      p_valor = ifelse(is.na(p_valores[i]), "NA", sprintf("%15.4f", p_valores[i]))  # Formata o p-valor alinhado

      # Adicionar asterisco se p < 0.05
      asterisco = ifelse(!is.na(p_valores[i]) && as.numeric(p_valores[i]) < 0.05, "*", "")

      # Construir a linha formatada com 25 espaços para o nome da variável
      resultado[i + 1] = sprintf("%-25s %15s %15s%s", beta_nome, beta_valor, p_valor, asterisco)
    }
    return(resultado)
  }

  # Calcular R² e R² ajustado
  r2_resultados = calcular_r2(modelo_retorno)

  # Se R == 1, imprimir os resultados
  if (R == 1) {
    # Primeiro, imprimir o resumo dos resíduos sem o título de variável
    cat("Resumo dos Resíduos:\n")
    resumo_residuos = summary(as.numeric(residuos_resultado))  # Converter os resíduos para formato numérico
    print(resumo_residuos)
    cat("\n")

    # Depois, imprimir os coeficientes e p-valores com os nomes das variáveis
    resultado_formatado = format_output(betas_resultado, p_valores_resultado, nomes_variaveis)
    for (linha in resultado_formatado) {
      cat(linha, "\n")
    }

    # Finalmente, imprimir o R² e o R² ajustado
    cat("\nR²: ", sprintf("%.4f", r2_resultados$r2), "\n")
    cat("R² Ajustado: ", sprintf("%.4f", r2_resultados$r2_ajustado), "\n")
  }

  # Predizer valores y novos
  valores_preditos = predicao(modelo_retorno, x)  # Usar as variáveis explicativas de treino para prever y

  # Retornar os resultados
  return(list(
    betas = betas_resultado,
    p_valores = p_valores_resultado,
    residuos = residuos_resultado,
    r2 = r2_resultados$r2,
    r2_ajustado = r2_resultados$r2_ajustado,
    valores_preditos = valores_preditos,
    valores_y = modelo_retorno$Y
  ))
}






