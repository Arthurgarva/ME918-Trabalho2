#' @title Conjunto de Dados Simulados
#' @description
#' Este conjunto de dados simula variáveis econômicas como Crescimento do PIB, Inflação,
#' Taxa de Desemprego, e variáveis explicativas como Gastos Governamentais,
#' Investimento Estrangeiro, Exportações, e Importações. Os dados são gerados usando
#' uma seed fixa para garantir reprodutibilidade.
#' @format Um data frame com 100 linhas e 7 colunas:
#' \describe{
#'   \item{Crescimento_PIB}{Crescimento do PIB (em percentagem)}
#'   \item{Inflacao}{Taxa de Inflação (em percentagem)}
#'   \item{Gastos_Governamentais}{Gastos Governamentais (em milhões de dólares)}
#'   \item{Investimento_Estrangeiro}{Investimento Estrangeiro (em milhões de dólares)}
#'   \item{Exportacoes}{Exportações (em milhões de dólares)}
#' }
#' @examples
#' data(ibge)
#' head(ibge)
"ibge"
