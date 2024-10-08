% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculaR2.R
\name{calcular_r2}
\alias{calcular_r2}
\title{R² e R² Ajustado}
\usage{
calcular_r2(modelo_retorno)
}
\arguments{
\item{modelo_retorno}{list. O retorno da função modelo(), contendo as matrizes X e Y.}
}
\value{
Uma lista contendo o R² e o R² ajustado.

Retorna uma lista contendo o R² e o R² ajustado.
}
\description{
Calcula o R² e o R² ajustado a partir de uma regressão linear.
}
\details{
A função compara os valores observados com os preditos e calcula a
proporção da variabilidade explicada pelo modelo (R²) e uma versão ajustada
que considera o número de variáveis explicativas (R² ajustado).
}
\examples{
calcular_r2(modelo)
}
