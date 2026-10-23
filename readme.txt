Autores: Amós Hsieh Carneiro Garcia e Dyogo Romagna Bendo

Esse programa encontra o caminho de menor custo entre duas estações, utilizando o Algoritmo A*. 

Para a execução desse sistema, é necessário ter previamente instalado um interpretador Prolog. O programa foi testado com o SWI-Prolog, disponível em: https://www.swi-prolog.org/. 

Com o SWI-Prolog instalado, basta executar os comandos:
swipl main.pl
?- executa('nome_arquivo.txt').

E será impresso o melhor caminho, dado a estação inicial, a estação final e a estrutura de conexão entre as estações, dadas pelo arquivo 'nome_arquivo.txt'. Existem dois exemplos que estão disponíveis para testes: 'e1.txt', 'e2.txt' e 'e3.txt'. O programa aceita apenas arquivos que estejam no seguinte padrão:

estacao_inicial(A).
estacao_final(B).
pode_ir(EstacaoA, EstacaoB, Distancia, Linha).
distLR(EstacaoA, EstacaoB, Distancia).

O programa está estruturado da seguinte forma:
- a_estrela.pl: implementação do algoritmo A*.
- leitura.pl: contém funções auxiliares para realizar a leitura dos fatos presentes no arquivo indicado.
- listas.pl: contém funções auxiliares para listas.
- main.pl: arquivo principal, com o predicado executa/1 e a impressão do caminho encontrado. 

