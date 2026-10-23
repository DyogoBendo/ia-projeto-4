:- [listas].
:- [leitura].
:- [a_estrela].

% executa(NomeArquivo): Carrega os dados do arquivo NomeArquivo, busca o menor caminho entre a estacao inicial e final usando A* e imprime o resultado.
% executa(+NomeArquivo)
executa(NomeArquivo) :-
    carrega_arquivo(NomeArquivo),
    estacao_inicial(Inicio),
    estacao_final(Fim),
    busca_a_estrela(Inicio, Fim, CaminhoVertices, CaminhoArestas, DistanciaTotal),
    !,
    write('Trajeto encontrado:'), nl,
    imprime_trajeto(CaminhoVertices, CaminhoArestas), nl,
    write('Distancia total percorrida: '), write(DistanciaTotal), nl.

executa(_) :-
    write('Nao e possivel chegar a estacao de destino a partir da estacao inicial.'), nl.

% imprime_trajeto(ListaEstacoes, ListaLinhas): Imprime ListaEstacoes e ListaLinhas, intercalando Estacao 0 -> Linha 0 -> Estacao 1 -> ... -> Linha N-1 -> Estacao N.
% imprime_trajeto(+ListaEstacoes, +ListaLinhas)
imprime_trajeto([UltimaEstacao], []) :-
    write(UltimaEstacao), !.
imprime_trajeto([EstacaoAtual|RestoEstacoes], [LinhaAtual|RestoLinhas]) :-
    write(EstacaoAtual),
    write(' -> '),
    write(LinhaAtual),
    write(' -> '),
    imprime_trajeto(RestoEstacoes, RestoLinhas).