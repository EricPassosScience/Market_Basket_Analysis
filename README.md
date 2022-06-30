# Market_Basket_Analysis_Linguagem R

ESPAÑOL:
Market Basket Analysis es una de las principales técnicas utilizadas por los grandes minoristas para descubrir asociaciones entre artículos. La técnica funciona buscando combinaciones de artículos que ocurren juntos con frecuencia en las transacciones. En otras palabras, permite a los minoristas identificar las relaciones entre los artículos que compra la gente.

En este mini-proyecto, usaremos el algoritmo Apriori con el lenguaje R para descubrir las reglas de asociación y, al final, presentaremos solo las reglas más fuertes en una hoja de cálculo de Excel.

Se utilizan 3 métricas principales para analizar el resultado del algoritmo Apriori, el más utilizado en MBA: Soporte: El soporte nos dice qué tan popular es un artículo (o conjunto de artículos), medido por la proporción de transacciones en las que el artículo (o conjunto de artículos) aparece; Confianza: La confianza nos dice la probabilidad de comprar el artículo Y cuando se compra el artículo X, expresada como {X -> Y}; Elevación: esta métrica indica cuánto ha aumentado nuestra confianza en que se comprará Y, dado que se ha comprado X. Finalmente, todavía tenemos el parámetro minlen del algoritmo Apriori en R, que indica la longitud mínima de la regla (por ejemplo, 3 elementos si el parámetro es igual a 3).

Se puede acceder fácilmente al conjunto de datos desde el siguiente enlace:https://snap.stanford.edu/data/amazon-meta.html


PORTUGUÊS:
A Análise de Cesta de Compras (Market Basket Analysis) é uma das principais técnicas usadas por grandes varejistas para descobrir associações entre itens. A técnica funciona procurando combinações de itens que ocorrem juntos com frequência nas transações. Em outras palavras, permite que os varejistas identifiquem as relações entre os itens que as pessoas compram.

Nesse mini-projeto, utilizaremos o algoritmo Apriori com a Linguagem R, para descobrirmos as regras de associação.E, no final, apresentaremos somente as regras mais fortes em uma planilha excel.  

São usadas 3 métricas principais para analisar o resultado do algoritmo Apriori, o mais usado em MBA:
Support: O support nos diz o quão popular é um item (ou conjunto de itens), conforme medido pela proporção de transações nas quais o item (ou conjunto de itens) aparece;
Confidence: A confidence nos diz a probabilidade de compra do item Y quando o item X é comprado, expresso como {X -> Y};
Lift: Essa métrica indica quanto aumentou nossa confiança de que Y será comprado, dado que X foi comprado. 
Por fim, ainda temos o paramêtro minlen do algoritmo Apriori em R, que indica o comprimento mínimo da regra (por exemplo3 itens se o parâmetro for igual a 3). 

O conjunto de dados pode ser facilmente acessado no link a seguir: https://snap.stanford.edu/data/amazon-meta.html
