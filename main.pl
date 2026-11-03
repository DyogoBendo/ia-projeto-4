:- [listas].
:- [leitura].
:- [busca_uniforme].

% executa(NomeArquivo): Carrega os dados do arquivo NomeArquivo, busca o menor caminho entre a estacao inicial e final usando Busca de Custo Uniforme e imprime o resultado.
% executa(+NomeArquivo)
executa(NomeArquivo) :-
    carrega_arquivo(NomeArquivo),
    estacao_inicial(Inicio),
    estacao_final(Fim),
    busca_uniforme(Inicio, Fim, CaminhoVertices, DistanciaTotal),
    !,
    write('Trajeto encontrado:'), nl,
    imprime_trajeto(CaminhoVertices), nl,
    write('Distancia total percorrida: '), write(DistanciaTotal), nl.

executa(_) :-
    write('Nao e possivel chegar a estacao de destino a partir da estacao inicial.'), nl.

% imprime_trajeto(ListaEstacoes): Imprime ListaEstacoes no formato Estacao 0 -> Estacao 1 -> ... -> Estacao N.
% imprime_trajeto(+ListaEstacoes)
imprime_trajeto([UltimaEstacao]) :-
    write(UltimaEstacao), !.
imprime_trajeto([EstacaoAtual|RestoEstacoes]) :-
    write(EstacaoAtual),
    write(' -> '),
    imprime_trajeto(RestoEstacoes).