# Market_Basket_Analysis_Linguagem R

A Análise de Cesta de Compras (Market Basket Analysis) é uma das principais técnicas usadas por grandes varejistas para descobrir associações entre itens. A técnica funciona procurando combinações de itens que ocorrem juntos com frequência nas transações. Em outras palavras, permite que os varejistas identifiquem as relações entre os itens que as pessoas compram.

Nesse mini-projeto, utilizaremos o algoritmo Apriori com a Linguagem R, para descobrirmos as regras de associação.E, no final, apresentaremos somente as regras mais fortes em uma planilha excel.  

São usadas 3 métricas principais para analisar o resultado do algoritmo Apriori, o mais usado em MBA:
Support: O support nos diz o quão popular é um item (ou conjunto de itens), conforme medido pela proporção de transações nas quais o item (ou conjunto de itens) aparece;
Confidence: A confidence nos diz a probabilidade de compra do item Y quando o item X é comprado, expresso como {X -> Y};
Lift: Essa métrica indica quanto aumentou nossa confiança de que Y será comprado, dado que X foi comprado. 
Por fim, ainda temos o paramêtro minlen do algoritmo Apriori em R, que indica o comprimento mínimo da regra (por exemplo3 itens se o parâmetro for igual a 3). 
