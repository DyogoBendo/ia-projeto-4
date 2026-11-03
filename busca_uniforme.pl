:- [listas].
:- [leitura].

% busca_uniforme(NoInicial, NoFinal, CaminhoVertices, DistanciaTotal):
% Algoritmo de Busca de Custo Uniforme para encontrar a DistanciaTotal e CaminhoVertices entre NoInicial e NoFinal.
% busca_uniforme(+NoInicial, +NoFinal, -CaminhoVertices, -DistanciaTotal)
busca_uniforme(NoInicial, NoFinal, CaminhoVertices, DistanciaTotal) :-
    FronteiraInicial = [no_fronteira(0, NoInicial, [NoInicial])],
    VisitadosInicial = [],
    busca_uniforme_fronteira(FronteiraInicial, VisitadosInicial, NoFinal,
                             CaminhoVerticesInvertido, DistanciaTotal),
    inverte_lista(CaminhoVerticesInvertido, CaminhoVertices).

% busca_uniforme_fronteira(Fronteira, Visitados, NoFinal, CamVerticesFim, DistFim):
% Percorre Fronteira ate atingir NoFinal, mantendo os nos visitados em Visitados e obtendo CamVerticesFim e DistFim.
% busca_uniforme_fronteira(+Fronteira, +Visitados, +NoFinal, -CamVerticesFim, -DistFim)

busca_uniforme_fronteira([no_fronteira(DistanciaTotal, NoFinal, CamVertices)|_],
                         _, NoFinal, CamVertices, DistanciaTotal) :- !.

busca_uniforme_fronteira([no_fronteira(_, NoAtual, _)|RestoFronteira],
                         Visitados, NoFinal, CamVerticesFim, DistFim) :-
    pertence(NoAtual, Visitados),
    !,
    busca_uniforme_fronteira(RestoFronteira, Visitados, NoFinal,
                             CamVerticesFim, DistFim).

busca_uniforme_fronteira([no_fronteira(DistAcumulada, NoAtual, CamVerticesAtual)|RestoFronteira],
                         Visitados, NoFinal, CamVerticesFim, DistFim) :-
    NovosVisitados = [NoAtual|Visitados],
    expande_vizinhos(NoAtual, DistAcumulada, CamVerticesAtual,
                     NovosVisitados, RestoFronteira, NovaFronteira),
    busca_uniforme_fronteira(NovaFronteira, NovosVisitados, NoFinal,
                             CamVerticesFim, DistFim).

% expande_vizinhos(NoAtual, DistAtual, CamVertices, Visitados, FronteiraAtual, NovaFronteira):
% Encontra todos os nos alcancaveis a partir de NoAtual, calcula a nova distancia acumulada a partir de DistAtual, expande CamVertices do NoAtual para seus vizinhos que nao estao em Visitados, e os insere ordenadamente em FronteiraAtual produzindo NovaFronteira.
% expande_vizinhos(+NoAtual, +DistAtual, +CamVertices, +Visitados, +FronteiraAtual, -NovaFronteira)
expande_vizinhos(NoAtual, DistAtual, CamVertices, Visitados, FronteiraAtual, NovaFronteira) :-
    findall(
        no_fronteira(NovaDist, Vizinho, [Vizinho|CamVertices]),
        (
            pode_ir(NoAtual, Vizinho, DistAresta),
            \+ pertence(Vizinho, Visitados),
            NovaDist is DistAtual + DistAresta
        ),
        ListaVizinhos
    ),
    insere_lista_ordenada(ListaVizinhos, FronteiraAtual, NovaFronteira).