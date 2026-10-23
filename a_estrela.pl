:- [listas].
:- [leitura].

% busca_a_estrela(NoInicial, NoFinal, CaminhoVertices, CaminhoArestas, DistanciaTotal):
% Algoritmo A* para encontrar a DistanciaTotal, CaminhoVertices e CaminhoArestas entre NoInicial e NoFinal.
% busca_a_estrela(+NoInicial, +NoFinal, -CaminhoVertices, -CaminhoArestas, -DistanciaTotal)
busca_a_estrela(NoInicial, NoFinal, CaminhoVertices, CaminhoArestas, DistanciaTotal) :-
    distLR(NoInicial, NoFinal, HeuristicaInicial),
    FronteiraInicial = [no_fronteira(HeuristicaInicial, 0, NoInicial, [NoInicial], [])],
    VisitadosInicial = [],
    busca_a_estrela_fronteira(FronteiraInicial, VisitadosInicial, NoFinal,
                              CaminhoVerticesInvertido, CaminhoArestasInvertido, DistanciaTotal),
    inverte_lista(CaminhoVerticesInvertido, CaminhoVertices),
    inverte_lista(CaminhoArestasInvertido, CaminhoArestas).

% busca_a_estrela_fronteira(Fronteira, Visitados, NoFinal, CamVerticesFim, CamArestasFim, DistFim):
% Percorre Fronteira ate atingir NoFinal, mantendo os nós visitados em Visitados e obtendo CamVerticesFim, CamArestasFim e DistFim.
% busca_a_estrela_fronteira(+Fronteira, +Visitados, +NoFinal, -CamVerticesFim, -CamArestasFim, -DistFim)

busca_a_estrela_fronteira([no_fronteira(_, DistanciaTotal, NoFinal, CamVertices, CamArestas)|_],
                          _, NoFinal, CamVertices, CamArestas, DistanciaTotal) :- !.

busca_a_estrela_fronteira([no_fronteira(_, _, NoAtual, _, _)|RestoFronteira],
                          Visitados, NoFinal, CamVerticesFim, CamArestasFim, DistFim) :-
    pertence(NoAtual, Visitados),
    !,
    busca_a_estrela_fronteira(RestoFronteira, Visitados, NoFinal,
                              CamVerticesFim, CamArestasFim, DistFim).

busca_a_estrela_fronteira([no_fronteira(_, DistAcumulada, NoAtual, CamVerticesAtual, CamArestasAtual)|RestoFronteira],
                          Visitados, NoFinal, CamVerticesFim, CamArestasFim, DistFim) :-
    NovosVisitados = [NoAtual|Visitados],
    expande_vizinhos(NoAtual, DistAcumulada, CamVerticesAtual, CamArestasAtual,
                     NoFinal, NovosVisitados, RestoFronteira, NovaFronteira),
    busca_a_estrela_fronteira(NovaFronteira, NovosVisitados, NoFinal,
                              CamVerticesFim, CamArestasFim, DistFim).

% expande_vizinhos(NoAtual, DistAtual, CamVertices, CamArestas, NoFinal, Visitados, FronteiraAtual, NovaFronteira):
% Encontra todos os nos alcancaveis a partir de NoAtual, calcula F = G + H a partir de DistAtual e a heurística para NoFinal, expande CamVertices e CamArestas do NoAtual para seus vizinhos que não estão em Visitados, e os insere em FronteiraAtual produzindo NovaFronteira. 
% expande_vizinhos(+NoAtual, +DistAtual, +CamVertices, +CamArestas, +NoFinal, +Visitados, +FronteiraAtual, -NovaFronteira)
expande_vizinhos(NoAtual, DistAtual, CamVertices, CamArestas, NoFinal, Visitados, FronteiraAtual, NovaFronteira) :-
    findall(
        no_fronteira(CustoF, NovoG, Vizinho, [Vizinho|CamVertices], [Linha|CamArestas]),
        (
            pode_ir(NoAtual, Vizinho, DistAresta, Linha),
            \+ pertence(Vizinho, Visitados),
            NovoG is DistAtual + DistAresta,
            distLR(Vizinho, NoFinal, CustoH),
            CustoF is NovoG + CustoH
        ),
        ListaVizinhos
    ),
    insere_lista_ordenada(ListaVizinhos, FronteiraAtual, NovaFronteira).