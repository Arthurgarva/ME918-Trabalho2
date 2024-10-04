
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ME918-Trabalho2

Este programa pacote carrega um banco de dados simulado sobre dados
economicos, uma série de funções e testes de validação para as mesmas.
Nele há um arquivo do tipo R denominado “testador.R” no qual se pode ver
alguns exemplos de como utilizar o programa e suas funções principais.
As funções implementadas neste pacote estão separadas em dois grupos, as
de nível baixos que servem somante para facilitar o funcionamento das
principais, e as funções principais, as quais o usuário interage
diretamente.

Passos para rodar seu produto:

**1)** Abra o projeto no R, entre em “Build” e clique em “Install”.

**2)** Agora crie o arquivo em que deseja utilizar o pacote e carregue o
pacotte “library(teste)”

**3)** Pronto, você já pode usar as funções do pacote.

***Funções Principais :***

\-**Regressao(modelo desejado = modelo_retorno, R = 0 ou 1)**

Recebe de entrada o modelo de regressão e o R (determina se vai imprimir
um resumo (1) ou não (vazio ou 0)).

Esse programa realiza a regressão, em caso da matriz ser singular ele
utiliza a regularização ridge para corrigir o problema, retornando os
betas das variáveis (betas), os p valores das variáveis (p_valores), ou
seja, se são significantes, os residuos (residuos), as estatisticas R
quadrado e R quadrado ajustado (r2 e r2_ajustado), tabela com as
variaveis da regressao e os valores preditos para as variaveis
preditivas assinaladas (valores_preditos), valores originais de Y
(valores_Y)

Exemplo:

modelo_resultado = modelo(dados, Crescimento_PIB ~ Inflacao +
Gastos_Governamentais + Exportacoes)

regressao(modelo_resultado,1)

\-**Predicao(modelo desejado = modelo_retorno, novos_dados)**

Recebe de entrada o modelo de regressão previamente ajustado (o retorno
da função modelo) e uma matriz com os novos dados (sem a coluna de
intercepto). A função realiza a predição dos valores de Y para os novos
dados fornecidos. Se a matriz for singular durante a fase de ajuste, a
regularização Ridge é aplicada automaticamente.

A função retorna um data frame contendo as variáveis explicativas
fornecidas e os valores preditos correspondentes.

Exemplo:

modelo_resultado = modelo(dados, Crescimento_PIB ~ Inflacao +
Gastos_Governamentais + Exportacoes)

novos_dados \<- data.frame( Inflacao = c(-16.754, -35.879),
Gastos_Governamentais = c(50.145, 60.345), Exportacoes = c(98.754,
104.765) )

valores_preditos = predicao(modelo_resultado, novos_dados)

\-**Grafico_residuos(resultado_regressao)**

Recebe como entrada o resultado da função regressao(), e gera um gráfico
de resíduos versus valores preditos. Esse gráfico é útil para
identificar padrões nos resíduos e verificar se a suposição de
homocedasticidade é válida (resíduos com variância constante).

O gráfico exibe os valores preditos no eixo x e os resíduos no eixo y, e
uma linha de referência horizontal é adicionada em y = 0 para ajudar a
visualizar a distribuição dos resíduos em torno de zero.

Exemplo:

modelo_resultado = modelo(dados, Crescimento_PIB ~ Inflacao +
Gastos_Governamentais + Exportacoes)

resultado_regressao = regressao(modelo_resultado, 0)

grafico_residuos(resultado_regressao)

\-**Grafico_p_o(resultado_regressao)**

Esta função gera o gráfico de valores preditos versus valores observados
com base no resultado da função regressao(). Esse gráfico ajuda a
avaliar a precisão do modelo de regressão, comparando os valores
preditos pelo modelo com os valores observados da variável resposta.

No gráfico, os valores observados são exibidos no eixo x e os valores
preditos no eixo y. Uma linha de referência y = x é adicionada para
verificar como os valores preditos se alinham com os valores observados.

Exemplo:

modelo_resultado = modelo(dados, Crescimento_PIB ~ Inflacao +
Gastos_Governamentais + Exportacoes)

resultado_regressao = regressao(modelo_resultado, 0)

grafico_p_o(resultado_regressao)

\-**Modelo(dados, fórmula)**

A função modelo() tem o objetivo de preparar os dados para a regressão.
Ela recebe como entrada um data frame com as variáveis e uma fórmula que
define a relação entre a variável resposta e as variáveis explicativas.
A função retorna uma lista contendo:

X: uma matriz com as variáveis explicativas (preditoras). Y: uma matriz
com a variável resposta (dependente).

Exemplo:

“Exemplo de data frame com variáveis econômicas” dados \<- data.frame(
Crescimento_PIB = c(2.5, 3.0, 1.8, 2.2), Inflacao = c(4.0, 3.8, 4.5,
4.2), Gastos_Governamentais = c(100, 150, 200, 180), Exportacoes =
c(300, 320, 310, 330) )

modelo_resultado = modelo(dados, Crescimento_PIB ~ Inflacao +
Gastos_Governamentais + Exportacoes)

***Funções secundárias***

\-**Betas(X, Y)**

A função betas() calcula os coeficientes de regressão linear (também
chamados de betas) com base nas matrizes X (variáveis explicativas) e Y
(variável resposta). O cálculo é feito utilizando a fórmula clássica dos
mínimos quadrados:

𝛽=(𝑋′𝑋)−1 𝑋′𝑌

Se a matriz 𝑋′𝑋 for singular (não pode ser invertida), a função aplica a
regularização Ridge, que adiciona um pequeno valor λ (lambda) à diagonal
de 𝑋′𝑋, para tornar a inversão possível. A função retorna o vetor de
coeficientes estimados, incluindo o intercepto.

\-**P_valores(X, Y)** A função p_valores() calcula os p-valores
associados aos coeficientes de regressão, que indicam a significância
estatística de cada variável explicativa. Para isso, a função:

Calcula os coeficientes de regressão (usando a função betas()). Obtém a
matriz de covariância dos coeficientes. Calcula os erros padrão dos
coeficientes. Com base nos erros padrão, calcula os valores t (razão
entre os coeficientes e seus erros padrão). Com os valores t, os
p-valores são calculados com base na distribuição t de Student. Se a
matriz for singular, a regularização Ridge é aplicada para obter a
matriz de covariância e garantir a estabilidade dos cálculos.

\-**Residuos(X, Y)** A função residuos() calcula os resíduos da
regressão, que são a diferença entre os valores observados de Y e os
valores preditos pelo modelo. Os resíduos são dados por:

𝑒=𝑌−𝑌^(chapéu)

Onde 𝑌^ são os valores preditos. Esses resíduos podem ser usados para
diagnosticar o ajuste do modelo e verificar suposições como a
homocedasticidade.

\-**Preditos(X, Y)**

A função preditos() calcula os valores preditos dentro do conjunto de
dados de treino. Ela utiliza os coeficientes estimados pela função
betas() e aplica-os à matriz X para prever os valores de Y. O resultado
é um vetor com os valores ajustados (ou preditos) do modelo para os
dados originais.

\_**Calcular_r2**

A função calcular_r2() calcula dois indicadores que avaliam a qualidade
de um modelo de regressão:

R²: Mede a proporção da variação da variável resposta que é explicada
pelas variáveis preditoras. Um valor de R² próximo de 1 indica que o
modelo explica bem os dados, enquanto um valor próximo de 0 indica que o
modelo não é bom para explicar a variação dos dados.

R² ajustado: É uma versão do R² que ajusta o valor levando em
consideração o número de variáveis explicativas no modelo. Ele penaliza
modelos com muitas variáveis que não contribuem significativamente para
a explicação da variabilidade, evitando um aumento artificial do R².

A função recebe o modelo de regressão ajustado e retorna uma lista
contendo o R² e o R² ajustado. Ela faz isso comparando os valores
observados da variável resposta com os valores preditos pelo modelo.
